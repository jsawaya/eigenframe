class EigenFrame

  def eigen_layout(component_list, orientation, layout_width, layout_height)
    {
      type: "LinearLayout",
      component_list: component_list,
      orientation: orientation,
      layout_width: layout_width,
      layout_height: layout_height
    }
  end
    
  def eigen_horizontal_layout(component_list)
    eigen_layout(component_list, "horizontal", "match_parent", "match_parent")
  end
  
  def eigen_vertical_layout(component_list)
    eigen_layout(component_list, "vertical", "match_parent", "match_parent")
  end

end