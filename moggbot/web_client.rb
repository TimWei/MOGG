puts 'client was loaded'
class WebClient
  LAND_PAGE_URL = SECRET_MOGG
  RAW_INSERT_SCRIPT = "mogg_body = document.getElementsByTagName('body')[0];
mogg_button = document.createElement('button');
mogg_button.innerHTML = 'Start/Stop';
mogg_button.style.cssText = 'position: fixed;display: block;left: 2%;top: 45%;z-index:1000;';
mogg_button.onclick = function(){MOGG_TRIGGER = !MOGG_TRIGGER};
mogg_body.insertBefore(mogg_button,mogg_body.firstChild);"
  KEY_MAP = {
    up: 'w',
    right: 'd',
    down: 's',
    left: 'a'
  }

  def initialize
    @browser = Watir::Browser.new :chrome
    @browser.goto LAND_PAGE_URL
    insert_trigger    
  end

  def process_move direction
    @browser.send_keys Array.new(20){ KEY_MAP[direction] }
  end

  def get_pos
    @browser.execute_script 'return players[0]["temp"]["to"]'
  end

  def is_active?
    @browser.execute_script 'return MOGG_TRIGGER;'
  end
  private 
  def insert_trigger
    @browser.execute_script 'MOGG_TRIGGER = false;'
    @browser.execute_script RAW_INSERT_SCRIPT;
  end
end