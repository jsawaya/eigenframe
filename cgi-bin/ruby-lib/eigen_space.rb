class EigenFrame

  def eigen_space(x1, y1, x2, y2)
  {
    left: x1,
    top: y1,
    right: x2,
    bottom: y2
  }
  end

  def eigen_padding(x, y)
    eigen_space(x, y, x, y)
  end

  def eigen_margin(x, y)
    eigen_space(x, y, x, y)
  end

end