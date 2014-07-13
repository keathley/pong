class Paddle
  include Drawable

  WIDTH = 16
  HEIGHT = 96
  SPEED = 6

  attr_reader :side, :y, :ai
  alias ai? ai

  def initialize(side, ai=false)
    @ai = ai
    @side = side
    @y = Pong::HEIGHT / 2
  end

  def ai_move!(ball)
    return unless (y - ball.y).abs > SPEED
    if y > ball.y
      up!
    else
      down!
    end
  end

  def up!
    @y -= dy
    @y = HEIGHT/2 if y1 < 0
  end

  def down!
    @y += dy
    @y = Pong::HEIGHT - HEIGHT / 2 if y2 > Pong::HEIGHT
  end

  def x1
    case side
    when :left
      0
    when :right
      Pong::WIDTH - WIDTH
    end
  end

  def x2
    x1 + WIDTH
  end

  def y1
    y - HEIGHT / 2
  end

  def y2
    y1 + HEIGHT
  end

  private

  def dy
    SPEED
  end

  def color
    Gosu::Color::WHITE
  end
end