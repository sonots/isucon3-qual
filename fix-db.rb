#!/usr/bin/env ruby                                                                                        

require 'json'
require 'mysql2-cs-bind'
require 'redcarpet'

def connection
  config = JSON.parse(IO.read(File.dirname(__FILE__) + "/../config/#{ ENV['ISUCON_ENV'] || 'local' }.json"))['database']
  return $mysql if $mysql
  $mysql = Mysql2::Client.new(
    :host => config['host'],
    :port => config['port'],
    :username => config['username'],
    :password => config['password'],
    :database => config['dbname'],
    :reconnect => true,
  )
end

# データ取ってくる
mysql = connection
memos = mysql.xquery('SELECT * FROM memos')
@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => false, :space_after_headers => true)

# mdに変換
memos.each do |data|
  #puts data['id']
  md_content = @markdown.render(data['content'])
  mysql.xquery("UPDATE memos SET content = ? where id = ?", md_content, data['id'])
end
