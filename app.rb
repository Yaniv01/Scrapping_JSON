
require 'bundler'
Bundler.require
$:.unshift File.expand_path("./../lib", __FILE__)
require 'scrapper'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'google_drive'


# mails = Emails.new.perform (technique sans JSON)

json = File.read('db/emails.JSON')
mails = JSON.parse(json)


session = GoogleDrive::Session.from_config("./config.json")

ws = session.spreadsheet_by_key("1J_atnS6XH0aGbj3G5gBzJ0MtDKylRX_IFrl0f01sDTk").worksheets[0]

i = 1
mails.each do |key, value|
  ws[i, 1] = key
  ws[i, 2] = value
  i += 1
end

ws.save
