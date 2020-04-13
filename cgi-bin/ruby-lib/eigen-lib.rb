require 'json'
require_relative 'eigen_button'
require_relative 'eigen_icon'
require_relative 'eigen_image_view'
require_relative 'eigen_javascript'
require_relative 'eigen_layout'
require_relative 'eigen_line'
require_relative 'eigen_list_view'
require_relative 'eigen_popup_screen'
require_relative 'eigen_popup_text_view'
require_relative 'eigen_space'
require_relative 'eigen_text_view'


=begin
EigenFrame ruby class produces nested hash objects, that are converted to json by caller (cgi-bin) scripts,
and sent back to the EigenFrame app (or browser that invoked a url request).
See example: cgi-bin/cgi-directory-listview.rb
=end

class EigenFrame

 
  def eigen_directory_listview_http_cgi(dirpath)
  dirHash = set_directory_hash(dirpath)
  dirHashDirectory = dirHash['directory']

  listdir_url = "http://localhost:8080/cgi-bin/cgi-directory-listview.rb"
  subdir_url_script = "'#{listdir_url}?dirpath=#{dirHashDirectory}/' + eigenFragment.getOptionString('option', '.')"
  subdirListViewOnClickPopupScreen = launch_PopupScreen(20, "#ffffff", "#222222", [subdir_url_script])

  file_item_title_script_list =
    [
      "var title0 = 'File:  #{dirpath}' + '/'+ eigenFragment.getOptionString('option', '.')",
      "java.lang.System.out.println(title0)",
      "title0"
    ]

  list_contents_url = "http://localhost:8080/cgi-bin/cgi-list-termux-file-contents.rb"

  file_item_url_script_list =
    [
      "var url0 = '#{list_contents_url}?filepath=#{dirpath}' + '/'+ eigenFragment.getOptionString('option', '.')",
      "java.lang.System.out.println(url0)",
      "url0"
    ]

  filesListViewOnClickPopupTextView = popup_text_view(file_item_title_script_list, file_item_url_script_list)

  directory_listview(dirHash, subdirListViewOnClickPopupScreen, filesListViewOnClickPopupTextView)
end


def eigen_directory_listview_http_ruby(dirpath)
  dirHash = set_directory_hash(dirpath)
  dirHashDirectory = dirHash['directory']

  listdir_url = "http://localhost:1234/listdir"
  subdir_url_script = "'#{listdir_url}?dirpath=#{dirHashDirectory}/' + eigenFragment.getOptionString('option', '.')"
  subdirListViewOnClickPopupScreen = launch_PopupScreen(20, "#ffffff", "#222222", [subdir_url_script])

  file_item_title_script_list =
    [
      "var title0 = 'File:  #{dirpath}' + '/'+ eigenFragment.getOptionString('option', '.')",
      "java.lang.System.out.println(title0)",
      "title0"
    ]

  list_contents_url = "http://localhost:1234/list_contents"
  file_item_url_script_list =
    [
      "var url0 = '#{list_contents_url}?filepath=#{dirpath}' + '/'+ eigenFragment.getOptionString('option', '.')",
      "java.lang.System.out.println(url0)",
      "url0"
    ]

  filesListViewOnClickPopupTextView = popup_text_view(file_item_title_script_list, file_item_url_script_list)

  directory_listview(dirHash, subdirListViewOnClickPopupScreen, filesListViewOnClickPopupTextView)
end


def eigen_directory_listview_ssh(dirpath)
  dirHash = set_directory_hash(dirpath)
  dirHashDirectory = dirHash['directory']

  subdir_ssh_script = "'cd /data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin; ruby ssh-directory-listview.rb #{dirHashDirectory}/' + eigenFragment.getOptionString('option', '.')"
  subdirListViewOnClickPopupScreen = launch_PopupScreen_SecureShell(20, "#ffffff", "#222222", [subdir_ssh_script])

  file_item_title_script_list =
    [
      "var title0 = 'File:  #{dirpath}' + '/'+ eigenFragment.getOptionString('option', '.')",
      "java.lang.System.out.println(title0)",
      "title0"
    ]


  file_item_ssh_script_list =
    [
      "var filepath0 = '#{dirpath}/' + eigenFragment.getOptionString('option', '.')",
      "java.lang.System.out.println('js filepath0: '+filepath0)",
      "var ssh_cmd = 'cd /data/data/com.termux/files/home/git-repos/eigenframe/cgi-bin; ruby ssh-list-termux-file-contents.rb ' + filepath0",
      "java.lang.System.out.println('js ssh_cmd: '+ssh_cmd)",
      "ssh_cmd"
    ]

  filesListViewOnClickPopupTextView = popup_text_view_ssh_script_list(file_item_title_script_list, file_item_ssh_script_list)


#  list_contents_url = "http://localhost:1234/list_contents"

#  file_item_url_script_list =
#    [
#      "var url0 = '#{list_contents_url}?filepath=#{dirpath}' + '/'+ eigenFragment.getOptionString('option', '.')",
#      "java.lang.System.out.println(url0)",
#      "url0"
#    ]

#  filesListViewOnClickPopupTextView = popup_text_view(file_item_title_script_list, file_item_url_script_list)

  directory_listview(dirHash, subdirListViewOnClickPopupScreen, filesListViewOnClickPopupTextView)
end


## new
def directory_listview(dirHash, subdirListViewOnClickPopupScreen, filesListViewOnClickPopupTextView)
  padding = eigen_padding(5, 5)
  margin = eigen_margin(10, 10)
  infoLeftIcon = eigen_icon("info.jpg", "left")
  horzLine = EigenLine.new.eigen_horizontal_line(3, "#0000ff")
  vertLine = EigenLine.new.eigen_vertical_line(3, "#0000ff")

  dirHashDirectory = dirHash['directory']

  headerTextView = eigen_text_view(24, "#ffffff", padding, margin, ["'List Directory: #{dirHashDirectory}'"])

  text_script_list = ["eigenFragment.getOptionInteger('position', 0) + ': ' + eigenFragment.getOptionString('option', '')"]

  subdirRowLayout = eigen_text_view(20, "#ffffff", padding, margin, text_script_list)

  subdirListView = list_view(dirHash["subdir"], subdirRowLayout, subdirListViewOnClickPopupScreen)

  fileRowLayout = eigen_text_view(20, "#ffffff", padding, margin, text_script_list)

  filesListView = list_view(dirHash["files"], fileRowLayout, filesListViewOnClickPopupTextView)

  layout0 = eigen_horizontal_layout([vertLine,subdirListView,vertLine,filesListView,vertLine])

  eigen_vertical_layout([headerTextView,horzLine,layout0])
end




def parent_path(dirpath)
  last_slash_index = dirpath.rindex('/')
  dirpath[0..last_slash_index]
end

end
## end of class