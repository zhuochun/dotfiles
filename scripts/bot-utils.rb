# frozen_string_literal: true
require 'time'
require 'http'

def time_ago(t)
  elapsed = Time.now - t

  case
  when elapsed >= 172_800 # 2 days
    '%d days' % [elapsed / 86_400]
  when elapsed >= 86_400 # 1 day
    '%d day' % [elapsed / 86_400]
  when elapsed >= 7200 # 2 hours
    '%d hrs' % [elapsed / 3600]
  when elapsed >= 3600
    '%d hr' % [elapsed / 3600]
  when elapsed >= 120 # 2 mins
    '%d mins' % [elapsed / 60]
  else
    '%d min' % [elapsed / 60]
  end
end

# Send slack messages
#
# Slack.new(webhook, username, [':apple:']).send(channel, msg)
class Slack
    attr_reader :webhook, :username, :icon_emojis

    def new(webhook, username, icon_emojis)
        @webhook = webhook
        @username = username
        @icon_emojis = Array(icon_emojis)
    end

    def send(channel, msg)
      payload = {
        channel: channel,
        username: @username,
        icon_emoji: @icon_emojis.sample,
        text: msg
      }

      HTTP.post(@hook, json: payload)
    end
end

# Use File modification time as a time lock
#
# l = FileTimeLock.new(File)
# l.lockOnDate(time.new)
# l.lockOnHour(time.new)
class FileTimelock
    attr_reader :file

    def initialize(file)
        @file = file

        File.new(file, 'w').close() unless File.exist?(file)
    end

    def lockedAt
        File.mtime(@file)
    end

    # lock if the file is not modified on/after the date of t
    def lockOnDate(t)
        l = lockedAt
        return false if t.to_date <= l.to_date

        updateLock(t)
        true
    end

    # lock if the file is not modified after/at the date and the hour of t
    def lockOnHour(t)
        l = lockedAt
        return false if t.to_date < l.to_date || t.hour <= l.hour

        updateLock(t)
        true
    end

    def updateLock(t)
        File.utime(File.atime(@file), t, @file)
    end
end
