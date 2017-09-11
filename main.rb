require 'watir'
require 'pry'
require_relative 'move_path'
require_relative 'moggbot/client'
require_relative 'moggbot/behavior'
require_relative 'moggbot'
#browser = Watir::Browser.new :chrome
bot = Moggbot.new :web
bot.start
binding.pry