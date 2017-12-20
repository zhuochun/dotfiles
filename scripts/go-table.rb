#!/usr/bin/env ruby
# encoding: utf-8

require 'mysql2'
require 'ERB'

# Generate a struct from database schema
#
# Usage:
#
#   ./go-table.rb database tablename StructName
#
# Dependencies:
#
#   Mysql2: gem install mysql2
#

# https://golang.org/pkg/database/sql/#pkg-index
# https://godoc.org/github.com/go-sql-driver/mysql#NullTime
TYPE_MAP = {
  'int'           => 'int64',
  'bigint'        => 'int64',
  'int_null'      => 'sql.NullInt64',
  'tinyint'       => 'bool',
  'tinyint_null'  => 'sql.NullBool',
  'decimal'       => 'float64',
  'decimal_null'  => 'sql.NullFloat64',
  'float'         => 'float64',
  'float_null'    => 'sql.NullFloat64',
  'varchar'       => 'string',
  'varchar_null'  => 'sql.NullString',
  'text'          => 'string',
  'text_null'     => 'sql.NullString',
  'datetime'      => 'time.Time',
  'datetime_null' => 'mysql.NullTime'
}.freeze

class EntityTemplate
  attr_reader :entity_name, :p_entity_name, :schema, :db

  def initialize(entity_name, schema, db)
    @entity_name = entity_name.dup
    @p_entity_name = entity_name.dup # p is private struct name
    @p_entity_name[0] = @p_entity_name[0].downcase
    @schema = schema
    @db = db
  end

  def to_gotype(type, nullable)
    key = type.split('(').first
    key += '_null' if nullable == 'YES'

    TYPE_MAP.fetch(key)
  end

  def primary_key
    schema.first { |row| row['Key'] == 'PRI' }
  end

  def camelcase(name, lower = false)
    str = name.split('_').map(&:capitalize).map { |w| w == 'Id' ? 'ID' : w }.join
    str[0] = str[0].downcase if lower
    str
  end

  def render
    ERB.new(structErb, nil, '-').result(binding)
  end

  def structErb
    <<-EOS
// <%= entity_name %>Ref is a reference object to <%= entity_name %>
var <%= entity_name %>Ref = &<%= entity_name %>{}

// <%= entity_name %> defines a struct that map to one row in <%= db[:database] %>.<%= db[:table] %> table
type <%= entity_name %> struct {
<% schema.each do |row| -%>
<% if row['Key'] == 'PRI' -%>
  <%= camelcase(row['Field']) %> <%= to_gotype(row['Type'], row['Null']) %> `sql-col:"<%= row['Field'] %>" sql-insert:"false" sql-key:"<%= row['Field'] %>"`
<% else -%>
  <%= camelcase(row['Field']) %> <%= to_gotype(row['Type'], row['Null']) %> `sql-col:"<%= row['Field'] %>"`
<% end -%>
<% end -%>
}

// GetID implements the GetID function for Entity Interface
func (data *<%= entity_name %>) GetID() string {
  return strconv.FormatInt(data.ID, 10)
}

// SetID implements the SetID function for Entity Interface
func (data *<%= entity_name %>) SetID(ID string) {
  data.ID, _ = strconv.ParseInt(ID, 10, 64)
}

// NewEntity implements the NewEntity function for Entity Interface
func (data *<%= entity_name %>) NewEntity() orm.Entity {
  return &<%= entity_name %>{}
}

// GetTableName implements the GetTableName for MysqlData interface
func (data *<%= entity_name %>) GetTableName() string {
  return "<%= db[:table] %>"
}
    EOS
  end
end

# ARGV Logic
if ARGV.length < 3
  $stdout << "Usage: ./go-table.rb database tablename StructName\n"
  exit(1)
end

db_config = {
  host: 'localhost',
  username: 'root',
  database: ARGV[0]
}

client = Mysql2::Client.new(db_config)
table = ARGV[1]
entity_name = ARGV[2]

schema = client.query("DESCRIBE #{table};")
template = EntityTemplate.new(entity_name, schema, db_config.merge(table: table))
$stdout << template.render
