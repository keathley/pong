module Drawable
  def draw(window)
    window.draw_quad(
      x1, y1, color,
      x1, y2, color,
      x2, y2, color,
      x2, y1, color
    )
  end

  def color
    raise NotImplementedError
  end

  def x1
    raise NotImplementedError
  end

  def x2
    raise NotImplementedError
  end

  def y1
    raise NotImplementedError
  end

  def y2
    raise NotImplementedError
  end
end