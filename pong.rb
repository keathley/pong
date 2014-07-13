require 'gosu'

# Game classes
require './ball.rb'
require './paddle.rb'

class Pong < Gosu::Window
  WIDTH = 768
  HEIGHT = 576

  def initialize(width=768, height=576, fullscreen=false)
    super
    self.caption = "Pong"
    @left_score = 0
    @right_score = 0
    @font = Gosu::Font.new(self, "Arial", 30)

    build_ball!
    @left_paddle = Paddle.new(:left, true)
    @right_paddle = Paddle.new(:right)
  end

  def draw
    @font.draw(@left_score, 30, 30, 0)
    @font.draw(@right_score, WIDTH - 50, 30, 0)

    @ball.draw(self)
    @left_paddle.draw(self)
    @right_paddle.draw(self)
  end

  def update
    @ball.move!

    handle_collision_detection!
    handle_player_input!
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  private

  def build_ball!
    @ball = Ball.new(self.width/2, self.height/2)
  end

  def handle_player_input!
    if @left_paddle.ai?
      @left_paddle.ai_move!(@ball)
    else
      @left_paddle.up! if button_down?(Gosu::KbW)
      @left_paddle.down! if button_down?(Gosu::KbS)
    end

    @right_paddle.up! if button_down?(Gosu::KbUp)
    @right_paddle.down! if button_down?(Gosu::KbDown)
  end

  def handle_collision_detection!
    if @ball.off_left?
      @right_score += 1
      build_ball!
    end

    if @ball.off_right?
      @left_score += 1
      build_ball!
    end

    @ball.bounce_off_paddle!(@left_paddle) if @ball.intersect?(@left_paddle)
    @ball.bounce_off_paddle!(@right_paddle) if @ball.intersect?(@right_paddle)
  end
end

Pong.new.show