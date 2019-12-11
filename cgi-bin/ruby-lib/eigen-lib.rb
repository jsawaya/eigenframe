=begin
EigenFrame class produces nested hash objects, that are converted to json by caller (cgi-bin) scripts,
and sent back to the EigenFrame app (or browser that invoked a url request).
See example: cgi-bin/sys-directory-listview.rb
=end


class EigenFrame

##==================================================================================================
def eigen_directory_listview(dirpath, listdir_url, list_contents_url)
  Dir.chdir dirpath
  dirHash = directory_hash()

  padding = eigen_padding(5, 5)
  margin = eigen_margin(10, 10)
  infoLeftIcon = eigen_icon("info.jpg", "left")
  horzLine = eigen_horizontal_line(2, "#00ff00")
  vertLine = eigen_vertical_line(2, "#00ff00")

  dirHashDirectory = dirHash['directory']

  headerTextView = eigen_text_view(24, "#ffffff", padding, margin, ["'List Directory: #{dirHashDirectory}'"])

  text_script_list = ["eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ': ' + eigenMap.get('metadata')"]

  subdirItemLayout = eigen_text_view(20, "#ffffff", padding, margin, text_script_list)

  #listdir_url = "http://localhost:8080/cgi-bin/sys-directory-listview.rb"
  #listdir_url = "http://localhost:1234/listdir"
  subdir_url_script = "'#{listdir_url}?dirpath=#{dirHashDirectory}' + '/'+ eigenMap.get('option')"

  subdirListViewOnClickPopupScreen = launch_PopupScreen(20, "#ffffff", "#222222", [subdir_url_script])

#  parent_path = File.expand_path("..", Dir.pwd)
#  parent_path = "#{dirpath}/.."
#  parent_path = parent_path(dirpath)

#  url_script_list0 = ["'#{listdir_url}?dirpath=#{parent_path}'"]

#  buttonOnClickPopupScreen = launch_PopupScreen(20, "#ffffff", "#222222", url_script_list0)
#  get_parent_directory_button = eigen_button(30, "#ffffff", "#2222ff", "#{parent_path}", buttonOnClickPopupScreen)

  subdirListView = list_view(dirHash["subdir"], subdirItemLayout, subdirListViewOnClickPopupScreen)

  #list_contents_url = "http://localhost:8080/cgi-bin/sys-list-termux-file-contents.rb"
  #list_contents_url = "http://localhost:1234/list_contents"

  #image_url_script_list =
  #  [
  #    "var url0 = '#{list_contents_url}?filepath=#{dirpath}' + '/'+ eigenMap.get('metadata')",
  #    "java.lang.System.out.println(url0)",
  #    "url0"
  #  ]

  #image_view = eigen_image_view(image_url_script_list)

  fileItemTextView = eigen_text_view(20, "#ffffff", padding, margin, text_script_list)

  #fileRowLayout = eigen_horizontal_layout([image_view,fileItemTextView])
  fileRowLayout = fileItemTextView

  file_item_title_script_list =
    [
      "var title0 = 'File:  #{dirpath}' + '/'+ eigenMap.get('option')",
      "java.lang.System.out.println(title0)",
      "title0"
    ]

  file_item_url_script_list =
    [
      "var url0 = '#{list_contents_url}?filepath=#{dirpath}' + '/'+ eigenMap.get('option')",
      "java.lang.System.out.println(url0)",
      "url0"
    ]

  filesListViewOnClickPopupTextView = popup_text_view(file_item_title_script_list, file_item_url_script_list)
  filesListView = list_view(dirHash["files"], fileRowLayout, filesListViewOnClickPopupTextView)

  layout0 = eigen_horizontal_layout([vertLine,subdirListView,vertLine,filesListView,vertLine])

#  eigen_vertical_layout([headerTextView,get_parent_directory_button,horzLine,layout0])
  eigen_vertical_layout([headerTextView,horzLine,layout0])
end

##==================================================================================================
## define frame for padding
def eigen_padding(x, y)
  {
    left: x,
    top: y,
    right: x,
    bottom: y
  }
end


##==================================================================================================
## define frame for margin
def eigen_margin(x, y)
  {
    left: x,
    top: y,
    right: x,
    bottom: y
  }
end


##==================================================================================================
## define frame for an icon - internal resource ImageGetter registered name, and location (top,left...)
def eigen_icon(name, location)
  {
    name: name,
    location: location
  }
end


##==================================================================================================
## define frame for a horizontal line with size/width(integer) and color(string)
def eigen_horizontal_line(size, color)
  {
    type: "HorizontalLine",
    size: size,
    color: color
  }
end


##==================================================================================================
## define frame for a vertical line with size/width(integer) and color(string)
def eigen_vertical_line(size, color)
  {
    type: "VerticalLine",
    size: size,
    color: color
  }
end


##==================================================================================================
def eigen_layout(component_list, orientation, layout_width, layout_height)
  {
    type: "LinearLayout",
    component_list: component_list,
    orientation: orientation,
    layout_width: layout_width,
    layout_height: layout_height
  }
end


##=================================================================================================
def eigen_horizontal_layout(component_list)
  eigen_layout(component_list, "horizontal", "match_parent", "match_parent")
end


##=================================================================================================
def eigen_vertical_layout(component_list)
  eigen_layout(component_list, "vertical", "match_parent", "match_parent")
end


##=================================================================================================
## this frame defines each row of the subdirectory list
def eigen_text_view(text_size, text_color, padding, margin, text_script_list)
  {
    type: "TextView",
    layout_width: "wrap_content",
    layout_height: "wrap_content",
    text_size: text_size,
    text_color: text_color,
    padding: padding,
    margin: margin,
    text_script_list: text_script_list
  }
end


##==================================================================================================
## this frame defines each row of the subdirectory list
def eigen_image_view(url_script_list)
  {
    type: "ImageView",
    url_script_list: url_script_list,
    layout_width: "100",
    layout_height: "100",
    on_click:
      {
        type: "JavaScript",
        script: "eigenActivity.showToast('image clicked')"
      }
  }
end


##==================================================================================================
## this frame defines how to launch a PopupScreen
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


## this frame defines PopupTextView called via on_click in the file ListView
def popup_text_view(title_script_list, url_script_list)
  {
    type: "PopupTextView",
    title_script_list: title_script_list,
    url_script_list: url_script_list
  }
end


def javascript(script_list)
  {
    type: "JavaScript",
    script_list: script_list
  }
end


## this frame defines the subdir ListView
def list_view(key_list, item_layout, eigenScript)
  {
    type: "ListView",
    key_list: key_list,
    item_layout: item_layout,
    on_click: eigenScript,
    layout_width: "match_parent",
    layout_height: "wrap_content",
    layout_weight: "1"
  }
end


##=================================================================================================
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


def parent_path(dirpath)
  last_slash_index = dirpath.rindex('/')
  dirpath[0..last_slash_index]
end

## end of class
end



