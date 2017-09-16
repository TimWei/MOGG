puts 'bot/behavior loaded'
module Behavior 
  BEHAVE_DTIME = 200 #ms

  def move direction
    loop do 
      puts 'trying to move:  ' + direction.to_s
      @pre_pos              = get_pos
      @client.process_move  direction
      tick
      @pos                  = get_pos
      if move_success?      direction
        break
      else
        puts 'move failed, retry'
      end
    end
  end 

  def get_pos
    @client.get_pos
  end

  def tick
    sleep (BEHAVE_DTIME..700).map{|t| t}.sample.to_f / 1000
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
    @client.is_active?
  end
end
