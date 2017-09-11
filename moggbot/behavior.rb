puts 'behavior was loaded'
module Behavior 
  #玩家座標 return players[0]["temp"]["to"]

  BEHAVE_DTIME = 600 #ms
  KEY_MAP = {
    up: 'w',
    right: 'd',
    down: 's',
    left: 'a'
  }

  def go direction
    loop do 
      puts 'trying to move:  ' + direction.to_s
      @pre_pos = get_pos
      @client.send_keys Array.new(20){ KEY_MAP[direction] }
      tick
      @pos = get_pos
      if move_success? direction
        break
      else
        puts 'move failed, retry'
      end
    end
  end 

  def get_pos
    @client.execute_script 'return players[0]["temp"]["to"]'
  end

  def tick
    sleep (BEHAVE_DTIME..1200).map{|t| t}.sample.to_f / 1000
  end

  def move_success? direction
    case direction
    when :up
      @pos['j'] - @pre_pos['j'] == 1
    when :right
      @pos['i'] - @pre_pos['i'] == 1
    when :down
      @pos['j'] - @pre_pos['j'] == -1
    when :left
      @pos['i'] - @pre_pos['i'] == -1
    end 
  end

  def active? 
    @client.execute_script 'return MOGG_TRIGGER;'
  end
end