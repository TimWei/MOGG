class Moggbot
  include Behavior
  include Client

  BOT_STATE = {
    :STOP => 0,
    :START => 1,
    :PAUSE => 2
  }

  def initialize client
    case client
    when :web
      @client = launch_client
    end
    @state = BOT_STATE[:PAUSE]
    @pos = {}
    @pre_pos = {}
    @moves = MOVE_PATH
  end

  def start
    loop do 
      case @state
      when BOT_STATE[:START]
        if active?
          move = @moves.shift
          go move
          @moves.push move
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