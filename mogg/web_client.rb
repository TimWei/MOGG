puts 'client loaded'
class WebClient
  prepend InjectUi

  KEY_MAP       = {
    up: 'w',
    right: 'd',
    down: 's',
    left: 'a'
  }

  def initialize opt
    @browser    = Watir::Browser.new :chrome
    @browser.goto opt[:url]    
  end

  def process_move direction
    @browser.send_keys Array.new(10){ KEY_MAP[direction] }
  end

  def get_pos
    @browser.execute_script 'return players[0]["temp"]["to"]'
  end

  def is_active?
    @browser.execute_script 'return MOGG_TRIGGER;'
  end

  def is_reload?
    @browser.execute_script 'return MOGG_RELOAD;'
  end

  def reloaded
    @browser.execute_script 'MOGG_RELOAD = !MOGG_RELOAD;'
  end
end
