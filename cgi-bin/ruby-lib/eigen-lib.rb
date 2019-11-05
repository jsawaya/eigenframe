

##==================================================================================================
## define frame for padding
def eigen_padding(x)
  padding = Hash.new("null")
  padding["left"] = x
  padding["top"] = x
  padding["right"] = x
  padding["bottom"] = x
  padding
end


##==================================================================================================
## define frame for padding
def eigen_margin(x)
  margin = Hash.new("null")
  margin["left"] = x
  margin["top"] = x
  margin["right"] = x
  margin["bottom"] = x
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
def eigen_directory_listview(dirpath)
  Dir.chdir dirpath
  h = directory_hash()

## declare all frames
  padding = eigen_padding(20)
  margin = eigen_margin(10)
  infoLeftIcon = eigen_icon("info.jpg", "left")
  horzLine = eigen_horizontal_line(2, "#00ff00")

  headerTextView = eigen_text_view(20, "#ffffff", padding, margin, "Directory: #{h['directory']}")
  subdirListViewEigenFrame = Hash.new("null")
  subdirListViewOnClickEigenScreen = Hash.new("null")
  subdirListViewOnClickJavaScript = Hash.new("null")
  filesListViewEigenFrame = Hash.new("null")
  filesListViewOnClickJavaScript = Hash.new("null")
  filesListViewOnClickPopupTextView = Hash.new("null")
  eigenScreenLayout = Hash.new("null")
  filesListView = Hash.new("null")
  subdirListView = Hash.new("null")



## this frame defines the subdirectory listview
  subdirListView["type"] = "ListView"
  subdirListView["id"] = 1700
  subdirListView["layout-width"] = "match_parent"
  subdirListView["layout-height"] = "wrap_content"
  subdirListView["layout-weight"] = "1"
  subdirListView["background-color"] = "#223456"
  subdirListView["key-list"] = h["subdir"]
  subdirListView["on-click"] = subdirListViewOnClickEigenScreen
  subdirListView["eigen-frame"] = subdirListViewEigenFrame


## this frame defines each row of the subdirectory list
  subdirListViewEigenFrame["type"] = "TextView"
  subdirListViewEigenFrame["text-script-list"] =
    [
      "eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ': ' + eigenMap.get('metadata')"
    ]
  subdirListViewEigenFrame["text-size"] = "30"
  subdirListViewEigenFrame["text-color"] = "#ffffff"
  subdirListViewEigenFrame["layout-width"] = "wrap_content"
  subdirListViewEigenFrame["layout-height"] = "wrap_content"
  subdirListViewEigenFrame["padding"] = padding
  subdirListViewEigenFrame["margin"] = margin

## this defines the EigenScreen executed on-click subdirListView
  subdirListViewOnClickEigenScreen["type"] = "EigenScreen"
  subdirListViewOnClickEigenScreen["layout-width"] = "match_parent"
  subdirListViewOnClickEigenScreen["layout-height"] = "wrap_content"
  subdirListViewOnClickEigenScreen["text"] = "EigenFrame"
  subdirListViewOnClickEigenScreen["text-size"] = "20"
  subdirListViewOnClickEigenScreen["text-color"] = "#ffffff"
  subdirListViewOnClickEigenScreen["background-color"] = "#111111"
  subdirListViewOnClickEigenScreen["url-script-list"] =
    [
      "'http://localhost:8080/cgi-bin/sys-directory-listview.rb?dirpath=#{dirpath}' + '/'+ eigenMap.get('option')"
    ]


## this frame defines the file ListView
  filesListView["type"] = "ListView"
  filesListView["id"] = 700
  filesListView["layout-width"] = "match_parent"
  filesListView["layout-height"] = "wrap_content"
  filesListView["layout-weight"] = "1"
  filesListView["background-color"] = "#123456"
  filesListView["key-list"] = h["files"]
  filesListView["eigen-frame"] = filesListViewEigenFrame
#  filesListView["on-click"] = filesListViewOnClickJavaScript
  filesListView["on-click"] = filesListViewOnClickPopupTextView


## this frame defines each row of the file list
  filesListViewEigenFrame["type"] = "TextView"
  filesListViewEigenFrame["text-script-list"] =
    [
      "eigenFragment.getMapValueInteger(eigenMap, 'position', 0) + ': ' + eigenMap.get('metadata')"
    ]
  filesListViewEigenFrame["text-size"] = "30"
  filesListViewEigenFrame["text-color"] = "#ffffff"
  filesListViewEigenFrame["layout-width"] = "wrap_content"
  filesListViewEigenFrame["layout-height"] = "wrap_content"
  filesListViewEigenFrame["padding"] = padding
  filesListViewEigenFrame["margin"] = margin


## this frame defines javascript called via on-click in the file ListView
  filesListViewOnClickJavaScript["type"] = "JavaScript"
  filesListViewOnClickJavaScript["script-list"] =
    [
      "var pos = eigenFragment.getMapValueInteger(eigenMap, 'position', 0)",
      "var opt = eigenMap.get('option')",
      "eigenActivity.showToast('ListView file selected: '+ pos + ' - ' + opt)"
    ]

## this frame defines PopupTextView called via on-click in the file ListView
  filesListViewOnClickPopupTextView["type"] = "PopupTextView"
  filesListViewOnClickPopupTextView["title-script-list"] =
    [
      "var title0 = 'File:  #{dirpath}' + '/'+ eigenMap.get('option')",
      "java.lang.System.out.println(title0)",
      "title0"
    ]
  filesListViewOnClickPopupTextView["url-script-list"] =
    [
      "var url0 = 'http://localhost:8080/cgi-bin/sys-list-termux-file-contents.rb?filepath=#{dirpath}' + '/'+ eigenMap.get('option')",
      "java.lang.System.out.println(url0)",
      "url0"
    ]

=begin
  subdirListViewOnClickJavaScript["type"] = "JavaScript"
  subdirListViewOnClickJavaScript["script-list"] =
    [
      "var pos = eigenFragment.getMapValueInteger(eigenMap, 'position', 0)",
      "var opt = eigenMap.get('option')",
      "eigenActivity.showToast('ListView subdir selected: '+ pos + ' - ' + opt)"
    ]
  subdirListView["on-click"] = subdirListViewOnClickJavaScript
=end


## this frame composes the EigenScreen layout
  eigenScreenLayout["type"] = "LinearLayout"
  eigenScreenLayout["orientation"] = "vertical"
  eigenScreenLayout["layout-width"] = "match_parent"
  eigenScreenLayout["layout-height"] = "match_parent"
  eigenScreenLayout["component-list"] = [headerTextView,horzLine,subdirListView,horzLine,filesListView]


## this produces json text which is returned by the url request (back to EigenFrame App)
  jj eigenScreenLayout
end




