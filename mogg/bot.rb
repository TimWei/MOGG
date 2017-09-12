puts 'bot loaded'
class Bot
  include Behavior

  BOT_STATE = {
    :STOP => 0,
    :START => 1,
    :PAUSE => 2
  }

  def initialize opt={}
    # 注入Client纇
    @client = opt[:client] || raise('Client not available')
    @state = BOT_STATE[:PAUSE]
    @pos = {}
    @pre_pos = {}
    @path = opt[:path] || []
  end

  def start
    loop do 
      case @state
      when BOT_STATE[:START]
        if active?
          next_pos = @path.shift
          move next_pos
          @path.push next_pos
        else
          puts 'Bot Pause!'
          @state = BOT_STATE[:PAUSE]
        end
      when BOT_STATE[:PAUSE]
        sleep 3
        if active? 
          puts 'Bot Start!'
          @state = BOT_STATE[:START]
        else 
          @state = BOT_STATE[:PAUSE] 
        end
      end
      break if @state == BOT_STATE[:STOP]
    end
  end

  #debug 
  def client
    @client
  end
end