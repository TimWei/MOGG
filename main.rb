require 'watir'
require 'pry'
require_relative 'move_path'
require_relative 'moggbot/web_client'
require_relative 'moggbot/behavior'
require_relative 'moggbot'


bot = Moggbot.new :web
bot.start