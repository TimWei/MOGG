puts 'client was loaded'
module Client
  LAND_PAGE_URL = SECRET_MOGG
  RAW_INSERT_SCRIPT = "mogg_body = document.getElementsByTagName('body')[0];
mogg_button = document.createElement('button');
mogg_button.innerHTML = 'Start/Stop';
mogg_button.style.cssText = 'position: fixed;display: block;left: 2%;top: 45%;z-index:1000;';
mogg_button.onclick = function(){MOGG_TRIGGER = !MOGG_TRIGGER};
mogg_body.insertBefore(mogg_button,mogg_body.firstChild);"

  def launch_client
    @browser = Watir::Browser.new :chrome
    @browser.goto LAND_PAGE_URL
    insert_trigger
    @browser
  end

  def insert_trigger
    @browser.execute_script 'MOGG_TRIGGER = false;'
    @browser.execute_script RAW_INSERT_SCRIPT;
  end
end