class EigenLine

  ## define frame for a horizontal line with size/width(integer) and color(string)
  def eigen_horizontal_line(size, color)
    {
      type: "HorizontalLine",
      size: size,
      color: color
    }
  end
  
  
  ## define frame for a vertical line with size/width(integer) and color(string)
  def eigen_vertical_line(size, color)
    {
      type: "VerticalLine",
      size: size,
      color: color
    }
  end

end