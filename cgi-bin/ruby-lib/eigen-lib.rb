=begin
EigenFrame class produces nested hash objects, that are converted to json by cgi-bin scripts,
and sent back to the EigenFrame app (or browser that invoked a url request).
See example: cgi-bin/sys-directory-listview.rb
=end


class EigenFrame

##==================================================================================================
## define frame for padding
def eigen_padding(x, y)
  padding = Hash.new("null")
  padding["left"] = x
  padding["top"] = y
  padding["right"] = x
  padding["bottom"] = y
  padding
end


##==================================================================================================
## define frame for margin
def eigen_margin(x, y)
  margin = Hash.new("null")
  margin["left"] = x
  margin["top"] = y
  margin["right"] = x
  margin["bottom"] = y
  margin
end


##==================================================================================================
## define frame for an icon - internal resource ImageGetter registered name, and location (top,left...)
def eigen_icon(name, location)
  infoLeftIcon = Hash.new("null")
  infoLeftIcon["name"] = name
  infoLeftIcon["location"] = location
  infoLeftIcon
end


##==================================================================================================
## define frame for a horizontal line with size/width(integer) and color(string)
def eigen_horizontal_line(size, color)
  horzLine = Hash.new("null")
  horzLine["type"] = "HorizontalLine"
  horzLine["size"] = size
  horzLine["color"] = color
  horzLine
end


##==================================================================================================
## define frame for a vertical line with size/width(integer) and color(string)
def eigen_vertical_line(size, color)
  vertLine = Hash.new("null")
  vertLine["type"] = "VerticalLine"
  vertLine["size"] = size
  vertLine["color"] = color
  vertLine
end


##==================================================================================================
def eigen_horizontal_layout(component_list)
  horizontalLayout = Hash.new("null")
  horizontalLayout["type"] = "LinearLayout"
  horizontalLayout["orientation"] = "horizontal"
  horizontalLayout["layout-width"] = "match_parent"
  horizontalLayout["layout-height"] = "match_parent"
  horizontalLayout["component-list"] = component_list
  horizontalLayout
end


##==================================================================================================
def eigen_vertical_layout(component_list)
  verticalLayout = Hash.new("null")
  verticalLayout["type"] = "LinearLayout"
  verticalLayout["orientation"] = "vertical"
  verticalLayout["layout-width"] = "match_parent"
  verticalLayout["layout-height"] = "match_parent"
  verticalLayout["component-list"] = component_list
  verticalLayout
end


##==================================================================================================
## this frame defines each row of the subdirectory list
def eigen_text_view(size, color, padding, margin, text_script_list)
  text_view = Hash.new("null")
  text_view["type"] = "TextView"
  text_view["layout-width"] = "wrap_content"
  text_view["layout-height"] = "wrap_content"
  text_view["text-size"] = size
  text_view["text-color"] = color
  text_view["padding"] = padding
  text_view["margin"] = margin
  text_view["text-script-list"] = text_script_list
#    [
#      "eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ': ' + eigenMap.get('metadata')"
#    ]
  text_view
end


##==================================================================================================
## this frame defines each row of the subdirectory list
def eigen_image_view(url_script_list)
  image_view = Hash.new("null")
  image_view["type"] = "ImageView"
  image_view["layout-width"] = "wrap_content"
  image_view["layout-height"] = "100"
#  image_view["text-size"] = size
#  image_view["text-color"] = color
#  image_view["padding"] = padding
#  image_view["margin"] = margin
  image_view["url-script-list"] = url_script_list
#  image_view["on-click"] = on_click_script
  image_view
end


##==================================================================================================
## this frame defines how to launch next EigenScreen
def launch_eigen_screen(size, color, background_color, url_script_list)
  eigenScreen = Hash.new("null")
  eigenScreen["type"] = "EigenScreen"
  eigenScreen["layout-width"] = "match_parent"
  eigenScreen["layout-height"] = "wrap_content"
  eigenScreen["text"] = "EigenFrame"
  eigenScreen["text-size"] = size
  eigenScreen["text-color"] = color
  eigenScreen["background-color"] = background_color
  eigenScreen["url-script-list"] = url_script_list
#    [
#      "'http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{dirpath}' + '/'+ eigenMap.get('option')"
#    ]
  eigenScreen
end


##==================================================================================================
## this frame defines PopupTextView called via on-click in the file ListView
def popup_text_view(title_script_list, url_script_list)
  filesListViewOnClickPopupTextView = Hash.new("null")
  filesListViewOnClickPopupTextView["type"] = "PopupTextView"
  filesListViewOnClickPopupTextView["title-script-list"] = title_script_list
  filesListViewOnClickPopupTextView["url-script-list"] = url_script_list
  filesListViewOnClickPopupTextView
end


##==================================================================================================
## this frame defines javascript called via on-click in the file ListView
=begin
  script_list =
    [
      "var pos = eigenFragment.getMapValueInteger(eigenMap, 'position', 0)",
      "var opt = eigenMap.get('option')",
      "eigenActivity.showToast('ListView subdir selected: '+ pos + ' - ' + opt)"
    ]

  #filesListView["on-click"] = javascript(script_list)
=end
def javascript(script_list)
  filesListViewOnClickJavaScript = Hash.new("null")
  filesListViewOnClickJavaScript["type"] = "JavaScript"
  filesListViewOnClickJavaScript["script-list"] = script_list
  filesListViewOnClickJavaScript
end


## this frame defines the subdir ListView
def subdir_list_view(key_list, itemLayout, eigenScript)
  subdirListView = Hash.new("null")
  subdirListView["type"] = "ListView"
  subdirListView["layout-width"] = "match_parent"
  subdirListView["layout-height"] = "wrap_content"
  subdirListView["layout-weight"] = "1"
  subdirListView["key-list"] = key_list
  subdirListView["eigen-frame"] = itemLayout
  subdirListView["on-click"] = eigenScript
  subdirListView
end


##==================================================================================================
## this frame defines the file ListView
def file_list_view(key_list, itemLayout, filesListViewOnClickPopupTextView)
  filesListView = Hash.new("null")
  filesListView["type"] = "ListView"
  filesListView["layout-width"] = "match_parent"
  filesListView["layout-height"] = "wrap_content"
  filesListView["layout-weight"] = "1"
  filesListView["key-list"] = key_list
  filesListView["eigen-frame"] = itemLayout
  filesListView["on-click"] = filesListViewOnClickPopupTextView
  filesListView
end


##==================================================================================================
def eigen_button(size, color, background_color, textString, buttonScript)
  button = Hash.new("null")
  button["type"] = "Button"
  button["layout-width"] = "wrap_content"
  button["layout-height"] = "wrap_content"
#  button["text"] = "Directory: #{h['directory']}"
  button["text"] = textString
  button["text-size"] = size
  button["text-color"] = color
  button["background-color"] = background_color
#  button["gravity"] = gravity
  button["on-click"] = buttonScript
  button
end


##==================================================================================================
def parent_path(dirpath)
  last_slash_index = dirpath.rindex('/')
  dirpath[0..last_slash_index]
end


##==================================================================================================
def eigen_directory_listview(dirpath)
  Dir.chdir dirpath
  dirHash = directory_hash()

  padding = eigen_padding(20, 10)
  margin = eigen_margin(0, 0)
  infoLeftIcon = eigen_icon("info.jpg", "left")
  horzLine = eigen_horizontal_line(2, "#00ff00")
  vertLine = eigen_vertical_line(2, "#00ff00")

  dirHashDirectory = dirHash['directory']

  headerTextView = eigen_text_view(30, "#ffffff", padding, margin, ["'List Directory: #{dirHashDirectory}'"])

  text_script_list = ["eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ': ' + eigenMap.get('metadata')"]

  subdirItemLayout = eigen_text_view(20, "#ffffff", padding, margin, text_script_list)

  fileItemTextView = eigen_text_view(20, "#ffffff", padding, margin, text_script_list)

#  url_script_list = ["'http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{dirpath}' + '/'+ eigenMap.get('option')"]
  url_script_list = ["'http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{dirHashDirectory}' + '/'+ eigenMap.get('option')"]

  subdirListViewOnClickEigenScreen = launch_eigen_screen(20, "#ffffff", "#222222", url_script_list)

  image_url_script_list0 = ["'file:///storage/emulated/0/Android/data/com.sawaya.eigenframe.full/files/image/eigenframe.png'"]
  image_url_script_list =
    [
      "var url0 = 'file://#{dirHashDirectory}/' + eigenMap.get('metadata')",
      "java.lang.System.out.println('imageUrl: '+url0)",
      "url0"
    ]

  image_view = eigen_image_view(image_url_script_list)
  fileRowLayout = eigen_horizontal_layout([image_view,fileItemTextView])


#  parent_path = File.expand_path("..", Dir.pwd)
#  parent_path = "#{dirpath}/.."
  parent_path = parent_path(dirpath)

  url_script_list0 = ["'http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{parent_path}'"]

  buttonOnClickEigenScreen = launch_eigen_screen(20, "#ffffff", "#222222", url_script_list0)
  button = eigen_button(30, "#ffffff", "#2222ff", "#{parent_path}", buttonOnClickEigenScreen)

  subdirListView = subdir_list_view(dirHash["subdir"], subdirItemLayout, subdirListViewOnClickEigenScreen)

  file_item_title_script_list =
    [
      "var title0 = 'File:  #{dirpath}' + '/'+ eigenMap.get('option')",
      "java.lang.System.out.println(title0)",
      "title0"
    ]

  file_item_url_script_list =
    [
      "var url0 = 'http://localhost:8080/cgi-bin/sys-list-termux-file-contents.rb?filepath=#{dirpath}' + '/'+ eigenMap.get('option')",
      "java.lang.System.out.println(url0)",
      "url0"
    ]

  filesListViewOnClickPopupTextView = popup_text_view(file_item_title_script_list, file_item_url_script_list)

  filesListView = file_list_view(dirHash["files"], fileRowLayout, filesListViewOnClickPopupTextView)

  layout0 = eigen_horizontal_layout([vertLine,subdirListView,vertLine,filesListView,vertLine])

  eigenScreenLayout = eigen_vertical_layout([horzLine,headerTextView,button,horzLine,layout0,horzLine])
  eigenScreenLayout
end

end
##==================================================================================================




