class EigenFrame

  def list_view(option_list, item_layout, eigenScript)
    {
      type: "ListView",
      option_list: option_list,
      item_layout: item_layout,
      on_click: eigenScript,
      layout_width: "match_parent",
      layout_height: "wrap_content",
      layout_weight: "1"
    }
  end

end