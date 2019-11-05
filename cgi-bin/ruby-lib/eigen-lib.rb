

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
## this defines an icon - internal resource ImageGetter registered name, and location (top,left...)
def eigen_icon(name, location)
  infoLeftIcon = Hash.new("null")
  infoLeftIcon["name"] = name
  infoLeftIcon["location"] = location
  infoLeftIcon
end


##==================================================================================================
## this defines a horizontal line with size/width(integer) and color(string)
def eigen_horizontal_line(size, color)
  horzLine = Hash.new("null")
  horzLine["type"] = "HorizontalLine"
  horzLine["size"] = size
  horzLine["color"] = color
  horzLine
end


##==================================================================================================
## this defines a vertical line with size/width(integer) and color(string)
def eigen_vertical_line(size, color)
  vertLine = Hash.new("null")
  vertLine["type"] = "VerticalLine"
  vertLine["size"] = size
  vertLine["color"] = color
  vertLine
end


##==================================================================================================
## this defines a horizontal line with size/width(integer) and color(string)
def eigen_text_view(size, color, padding, margin, text)
  headerTextView = Hash.new("null")
  headerTextView["type"] = "TextView"
  headerTextView["layout-width"] = "wrap_content"
  headerTextView["layout-height"] = "wrap_content"
  headerTextView["text-size"] = size
  headerTextView["text-color"] = color
  headerTextView["text"] = text
  headerTextView["padding"] = padding
  headerTextView["margin"] = margin
  headerTextView
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
def eigen_list_view_item_layout(size, color, padding, margin, text_script_list)
  subdirListViewEigenFrame = Hash.new("null")
  subdirListViewEigenFrame["type"] = "TextView"
  subdirListViewEigenFrame["layout-width"] = "wrap_content"
  subdirListViewEigenFrame["layout-height"] = "wrap_content"
  subdirListViewEigenFrame["text-size"] = size
  subdirListViewEigenFrame["text-color"] = color
  subdirListViewEigenFrame["padding"] = padding
  subdirListViewEigenFrame["margin"] = margin
  subdirListViewEigenFrame["text-script-list"] = text_script_list
#    [
#      "eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ': ' + eigenMap.get('metadata')"
#    ]
  subdirListViewEigenFrame
end


##==================================================================================================
## this frame defines how to launch next EigenScreen
def launch_eigen_screen(size, color, background_color, url_script_list)
  subdirListViewOnClickEigenScreen = Hash.new("null")
  subdirListViewOnClickEigenScreen["type"] = "EigenScreen"
  subdirListViewOnClickEigenScreen["layout-width"] = "match_parent"
  subdirListViewOnClickEigenScreen["layout-height"] = "wrap_content"
  subdirListViewOnClickEigenScreen["text"] = "EigenFrame"
  subdirListViewOnClickEigenScreen["text-size"] = size
  subdirListViewOnClickEigenScreen["text-color"] = color
  subdirListViewOnClickEigenScreen["background-color"] = background_color
  subdirListViewOnClickEigenScreen["url-script-list"] = url_script_list
#    [
#      "'http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{dirpath}' + '/'+ eigenMap.get('option')"
#    ]
  subdirListViewOnClickEigenScreen
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
def subdir_list_view(key_list, itemLayout, subdirListViewOnClickEigenScreen)
  subdirListView = Hash.new("null")
  subdirListView["type"] = "ListView"
  subdirListView["layout-width"] = "match_parent"
  subdirListView["layout-height"] = "wrap_content"
  subdirListView["layout-weight"] = "1"
  subdirListView["key-list"] = key_list
  subdirListView["eigen-frame"] = itemLayout
  subdirListView["on-click"] = subdirListViewOnClickEigenScreen
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
def eigen_directory_listview(dirpath)
  Dir.chdir dirpath
  dirHash = directory_hash()

  padding = eigen_padding(20, 10)
  margin = eigen_margin(0, 0)
  infoLeftIcon = eigen_icon("info.jpg", "left")
  horzLine = eigen_horizontal_line(2, "#00ff00")
  vertLine = eigen_vertical_line(2, "#00ff00")

  headerTextView = eigen_text_view(30, "#ffffff", padding, margin, "List Directory: #{dirHash['directory']}")
#  headerTextView = eigen_text_view(30, "#ffffff", padding, margin, "List Directory: #{dirpath}")

  text_script_list = ["eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ': ' + eigenMap.get('metadata')"]
  itemLayout = eigen_list_view_item_layout(20, "#ffffff", padding, margin, text_script_list)

  url_script_list = ["'http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{dirpath}' + '/'+ eigenMap.get('option')"]
  subdirListViewOnClickEigenScreen = launch_eigen_screen(20, "#ffffff", "#222222", url_script_list)

  subdirListView = subdir_list_view(dirHash["subdir"], itemLayout, subdirListViewOnClickEigenScreen)

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

  filesListView = file_list_view(dirHash["files"], itemLayout, filesListViewOnClickPopupTextView)

  layout0 = eigen_horizontal_layout([vertLine,subdirListView,vertLine,filesListView,vertLine])

  eigenScreenLayout = eigen_vertical_layout([horzLine,headerTextView,horzLine,layout0,horzLine])
  eigenScreenLayout
end




