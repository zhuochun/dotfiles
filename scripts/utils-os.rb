# Only use simple values for title and message (without spaces or special characters)
def os_notify(title, message)
  case RUBY_PLATFORM
  when /darwin/
    # Using osascript for macOS notifications.
    system(%Q(osascript -e 'display notification "#{message}" with title "#{title}"'))
  when /mswin|mingw|cygwin/
    # Construct a single-line PowerShell command.
    ps_script = [
      "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null",
      "$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)",
      "$toastXml = $template",
      "$toastNodeList = $toastXml.GetElementsByTagName('text')",
      "$toastNodeList.Item(0).AppendChild($toastXml.CreateTextNode('#{title}')) | Out-Null",
      "$toastNodeList.Item(1).AppendChild($toastXml.CreateTextNode('#{message}')) | Out-Null",
      "$toast = [Windows.UI.Notifications.ToastNotification]::new($toastXml)",
      "$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Ruby App')",
      "$notifier.Show($toast)"
    ].join('; ')

    # Execute the PowerShell command inline.
    system("powershell -ExecutionPolicy Bypass -Command \"#{ps_script}\"")
  end
end