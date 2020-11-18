class EigenFrame

  def eigen_button(text_size, text_color, background_color, textString, buttonScript)
    {
      type: "Button",
      text: textString,
      text_size: text_size,
      text_color: text_color,
      background_color: background_color,
      layout_width: "wrap_content",
      layout_height: "wrap_content",
      on_click: buttonScript
    }
  end

end