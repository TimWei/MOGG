puts 'web_client/inject_ui loaded'
module InjectUi
  def initialize opt
    super
    insert_trigger opt[:insert_script]
  end

  def insert_trigger script
    @browser.execute_script script
  end
end