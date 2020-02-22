class EigenFrame

  ## this frame defines how to launch a PopupScreen using a url_script_list
  def launch_PopupScreen(text_size, text_color, background_color, url_script_list)
    {
      type: "PopupScreen",
      layout_width: "match_parent",
      layout_height: "wrap_content",
      text: "PopupScreen",
      text_size: text_size,
      text_color: text_color,
      background_color: background_color,
      url_script_list: url_script_list
    }
  end
  
  
  ## this frame defines how to launch a PopupScreen using a ssh_script_list
  def launch_PopupScreen_SecureShell(text_size, text_color, background_color, ssh_script_list)
    {
       type: "PopupScreen",
       layout_width: "match_parent",
       layout_height: "wrap_content",
       text_size: "20",
       text_color: "#ffffff",
       background_color: "#111111",
       text: "File system explorer",
       icon: {
            name: "info.jpg",
            location: "left"
          },
          component_list: [
            {
              type: "TextView",
              layout_width: "match_parent",
              layout_height: "wrap_content",
              text: "SecureShell calls ruby to generate the following components:",
              text_size: "20",
              gravity: "CENTER_HORIZONTAL, CENTER_VERTICAL",
              text_color: "#ffffff"
            },
            {
              type: "SecureShell",
              is_eigen_response: true,
              ssh_script_list: ssh_script_list
            }
          ]
    }
  end
  
  
  ## this frame defines how to launch a PopupScreen using a ssh_script_list
  def launch_PopupScreen_UrlRequest(text_size, text_color, background_color, url_script_list)
    {
       type: "PopupScreen",
       layout_width: "match_parent",
       layout_height: "wrap_content",
       text_size: "20",
       text_color: "#ffffff",
       background_color: "#111111",
       text: "PopupScreen from UrlRequest",
       icon: {
            name: "info.jpg",
            location: "left"
          },
          component_list: [
            {
              type: "TextView",
              layout_width: "match_parent",
              layout_height: "wrap_content",
              text: "UrlRequest generates the following components:",
              text_size: "20",
              gravity: "CENTER_HORIZONTAL, CENTER_VERTICAL",
              text_color: "#ffffff"
            },
            {
              type: "UrlRequest",
              is_eigen_response: true,
              url_script_list: url_script_list
            }
          ]
    }
  end

end