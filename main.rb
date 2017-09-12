require 'watir'
require 'pry'
require_relative 'config/path'
require_relative 'config/url'
require_relative 'mogg/web_client/inject_ui'
require_relative 'mogg/web_client'
require_relative 'mogg/bot/behavior'
require_relative 'mogg/bot'

RAW_INSERT_SCRIPT = "MOGG_TRIGGER = false; mogg_body = document.getElementsByTagName('body')[0];mogg_button = document.createElement('button');mogg_button.innerHTML = 'Start/Stop';mogg_button.style.cssText = 'position: fixed;display: block;left: 2%;top: 45%;z-index:1000;';mogg_button.onclick = function(){MOGG_TRIGGER = !MOGG_TRIGGER};mogg_body.insertBefore(mogg_button,mogg_body.firstChild);"

web_client = WebClient.new url: SECRET_MOGG_URL, insert_script: RAW_INSERT_SCRIPT
bot = Bot.new client: web_client, path: MOVE_PATH
bot.start