class EigenFrame

  ## this frame defines PopupTextView called via on_click in the file ListView
  def popup_text_view(title_script_list, url_script_list)
    {
      type: "PopupTextView",
      title_script_list: title_script_list,
      font: "font/space-mono/SpaceMono-Regular.ttf",
      url_script_list: url_script_list
    }
  end
  
  
  ## this frame defines PopupTextView called via on_click in the file ListView
  def popup_text_view_ssh_script_list(title_script_list, ssh_script_list)
    {
      type: "PopupTextView",
      title_script_list: title_script_list,
      font: "font/space-mono/SpaceMono-Regular.ttf",
      ssh_script_list: ssh_script_list
    }
  end

end