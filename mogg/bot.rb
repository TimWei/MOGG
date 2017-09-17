puts 'bot loaded'
class Bot
  include Behavior

  BOT_STATE = {
    :STOP   => 0,
    :START  => 1,
    :PAUSE  => 2,
    :RELOAD => 3,
  }

  def initialize opt={}
    # 注入Client纇
    @client         = opt[:client] || raise('Client not available')
    @state          = BOT_STATE[:PAUSE]
    @path_blueprint = opt[:path] || [[:up,1],[:down,1]]
    @path           = @path_blueprint.clone
    @back_path      = []
    @pos            = {}
    @pre_pos        = {}
  end

  def start
    loop do 
      @state    = BOT_STATE[:RELOAD] if reload?
      case @state
      when BOT_STATE[:START]
        if active?
          #test path array
          path_test
          #get new path item
          path_item         = @path.shift
          direction, count  = path_item
          back_direction    = turn direction
          (1..count).each   do 
            move direction
          end
          @back_path.unshift [back_direction, count]
        else
          puts 'Bot Pause!'
          @state        = BOT_STATE[:PAUSE]
        end
      when BOT_STATE[:PAUSE]
        sleep 3
        if active? 
          puts 'Bot Start!'
          @state            = BOT_STATE[:START]
        else 
          @state            = BOT_STATE[:PAUSE] 
        end
      when BOT_STATE[:RELOAD]
        puts 'Bot Path Reload!'
        reload_path
        puts 'Bot Pause!'
        @state            = BOT_STATE[:PAUSE]
      end
      break if @state == BOT_STATE[:STOP]
    end
  end

  def turn direction
    {
      up:     :down,
      down:   :up,
      left:   :right,
      right:  :left
    }[direction]  
  end

  def path_test
    if @path.empty?
      @path           = @back_path
      @back_path      = []
    end
  end

  #debug 
  def client
    @client
  end
end