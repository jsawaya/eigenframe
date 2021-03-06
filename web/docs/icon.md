# ![Alt](../res/icon/mipmap-mdpi/ic_launcher_round.png "eigenframe") EigenFrame Icon Support

EigenFrame tab (EigenFragment) only allows internal icon names.
For example:
 > "icon_name": "ic_launcher_round."

* Most component types support an icon specification which contains an internal name attribute and may also include a location attribute:

  - icon location: {"left" (default) | "right" | "top" | "bottom"}

Internal icon example:
```json
{
   "type": "Button",
   "icon": {
      "name": "info.",
      "location": "left"
   }
}
```

In addition, popup components provide an optional icon for the title bar.

Some component types also support an external icon name : {"Button" | "CheckBox" | "Switch" "ToggleButton" | "TextView" | "HtmlView" | "PopupScreen" }.

External icons are small image files that you may dynamically add to the EigenFrame shared folder (/storage/emulated/0/Android/data/com.sawaya.eigenframe/files/...)

External icons may represent your own branding or trademark.

External icon example:
```json
{
  "type": "TextView",
  "layout_width": "match_parent",
  "text_color": "#ffffff",
  "text": "Share",
  "icon": {
    "name": "/storage/emulated/0/Android/data/com.sawaya.eigenframe/files/icon/white/baseline_share_white_18.png",
    "location": "left"
  }
}
```

Note: Currently RadioButton do not support icon attributes
Note: Icons do not scale to fit like with ImageView - it will be actual size.

internal icon name | image
------------------ | ----- 
ic_launcher. | ![icon](../res/icon/mipmap-hdpi/ic_launcher.png "icon")
ic_launcher_round. | ![icon](../res/icon/mipmap-hdpi/ic_launcher_round.png "icon")
add_photo. | ![icon](../res/icon/black/ic_add_a_photo_black_24dp.png "icon")
add. | ![icon](../res/icon/black/ic_add_black_24dp.png "icon")
archive. | ![icon](../res/icon/black/ic_archive_black_24dp.png "icon")
arrow_back. | ![icon](../res/icon/black/ic_arrow_back_black_24dp.png "icon")
arrow_down. | ![icon](../res/icon/black/ic_arrow_downward_black_24dp.png "icon")
arrow_forward. | ![icon](../res/icon/black/ic_arrow_forward_black_24dp.png "icon")
arrow_up. | ![icon](../res/icon/black/ic_arrow_upward_black_24dp.png "icon")
attach_file. | ![icon](../res/icon/black/ic_attach_file_black_24dp.png "icon")
attach_money. | ![icon](../res/icon/black/ic_attach_money_black_24dp.png "icon")
attachment. | ![icon](../res/icon/black/ic_attachment_black_24dp.png "icon")
av_timer. | ![icon](../res/icon/black/ic_av_timer_black_24dp.png "icon")
block. | ![icon](../res/icon/black/ic_block_black_24dp.png "icon")
bubble | ![icon](../res/icon/black/ic_bubble_chart_black_24dp.png "icon")
burst_mode. | ![icon](../res/icon/black/ic_burst_mode_black_24dp.png "icon")
cancel. | ![icon](../res/icon/black/ic_cancel_black_24dp.png "icon")
cache. | ![icon](../res/icon/black/ic_cached_black_24dp.png "icon")
camera_alt. | ![icon](../res/icon/black/ic_camera_alt_black_24dp.png "icon")
camera_front. | ![icon](../res/icon/black/ic_camera_front_black_24dp.png "icon")
camera_rear. | ![icon](../res/icon/black/ic_camera_rear_black_24dp.png "icon")
changes. | ![icon](../res/icon/black/ic_change_history_black_24dp.png "icon")
check. | ![icon](../res/icon/black/ic_check_black_24dp.png "icon")
check_circle. | ![icon](../res/icon/black/ic_check_circle_black_24dp.png "icon")
close. | ![icon](../res/icon/black/ic_close_black_24dp.png "icon")
cloud_download. | ![icon](../res/icon/black/ic_cloud_download_black_24dp.png "icon")
cloud_upload. | ![icon](../res/icon/black/ic_cloud_upload_black_24dp.png "icon")
comment. | ![icon](../res/icon/black/ic_comment_black_24dp.png "icon")
create. | ![icon](../res/icon/black/ic_create_black_24dp.png "icon")
create_folder. | ![icon](../res/icon/black/ic_create_new_folder_black_24dp.png "icon")
delete. | ![icon](../res/icon/black/ic_delete_black_24dp.png "icon")
do_not_disturb. | ![icon](../res/icon/black/ic_do_not_disturb_black_24dp.png "icon")
no_entry. | ![icon](../res/icon/black/ic_do_not_disturb_on_black_24dp.png "icon")
edit. | ![icon](../res/icon/black/ic_edit_black_24dp.png "icon")
email. | ![icon](../res/icon/black/ic_email_black_24dp.png "icon")
encryption. | ![icon](../res/icon/black/ic_enhanced_encryption_black_24dp.png "icon")
error. | ![icon](../res/icon/black/ic_error_black_24dp.png "icon")
favorite. | ![icon](../res/icon/black/ic_favorite_black_24dp.png "icon")
file_download. | ![icon](../res/icon/black/ic_file_download_black_24dp.png "icon")
file_upload. | ![icon](../res/icon/black/ic_file_upload_black_24dp.png "icon")
flash_auto. | ![icon](../res/icon/black/ic_flash_auto_black_24dp.png "icon")
flash_on. | ![icon](../res/icon/black/ic_flash_on_black_24dp.png "icon")
flip. | ![icon](../res/icon/black/ic_flip_black_24dp.png "icon")
folder. | ![icon](../res/icon/black/ic_folder_black_24dp.png "icon")
folder_shared. | ![icon](../res/icon/black/ic_folder_shared_black_24dp.png "icon")
folder_special. | ![icon](../res/icon/black/ic_folder_special_black_24dp.png "icon")
format_color_text. | ![icon](../res/icon/black/ic_format_color_text_black_24dp.png "icon")
forward_5. | ![icon](../res/icon/black/ic_forward_5_black_24dp.png "icon")
forward. | ![icon](../res/icon/black/ic_forward_black_24dp.png "icon")
grade. | ![icon](../res/icon/black/ic_grade_black_24dp.png "icon")
gradient. | ![icon](../res/icon/black/ic_gradient_black_24dp.png "icon")
help. | ![icon](../res/icon/black/ic_help_black_24dp.png "icon")
image. | ![icon](../res/icon/black/ic_image_black_24dp.png "icon")
import_export. | ![icon](../res/icon/black/ic_import_export_black_24dp.png "icon")
info. | ![icon](../res/icon/black/ic_info_black_24dp.png "icon")
open_browser. | ![icon](../res/icon/black/ic_open_in_browser_black_24dp.png "icon")
open_with. | ![icon](../res/icon/black/ic_open_with_black_24dp.png "icon")
openkeychain. | ![icon](../res/icon/ic_openkeychain.png "icon")
pageview. | ![icon](../res/icon/black/ic_pageview_black_24dp.png "icon")
party_mode. | ![icon](../res/icon/black/ic_party_mode_black_24dp.png "icon")
pause. | ![icon](../res/icon/black/ic_pause_black_24dp.png "icon")
perm_data_setting. | ![icon](../res/icon/black/ic_perm_data_setting_black_24dp.png "icon")
photo. | ![icon](../res/icon/black/ic_photo_camera_black_24dp.png "icon")
photo_library. | ![icon](../res/icon/black/ic_photo_library_black_24dp.png "icon")
photo_size. | ![icon](../res/icon/black/ic_photo_size_select_large_black_24dp.png "icon")
play. | ![icon](../res/icon/black/ic_play_arrow_black_24dp.png "icon")
playlist_check. | ![icon](../res/icon/black/ic_playlist_add_check_black_24dp.png "icon")
portrait. | ![icon](../res/icon/black/ic_portrait_black_24dp.png "icon")
redo. | ![icon](../res/icon/black/ic_redo_black_24dp.png "icon")
rotate_90. | ![icon](../res/icon/black/ic_rotate_90_degrees_ccw_black_24dp.png "icon")
rotate_left. | ![icon](../res/icon/black/ic_rotate_left_black_24dp.png "icon")
rotate_right. | ![icon](../res/icon/black/ic_rotate_right_black_24dp.png "icon")
save. | ![icon](../res/icon/black/ic_save_black_24dp.png "icon")
sd_card. | ![icon](../res/icon/black/ic_sd_card_black_24dp.png "icon")
search. | ![icon](../res/icon/black/ic_search_black_24dp.png "icon")
security. | ![icon](../res/icon/black/ic_security_black_24dp.png "icon")
settings_app. | ![icon](../res/icon/black/ic_settings_applications_black_24dp.png "icon")
settings. | ![icon](../res/icon/black/ic_settings_black_24dp.png "icon")
star. | ![icon](../res/icon/black/ic_star_black_24dp.png "icon")
stop. | ![icon](../res/icon/black/ic_stop_black_24dp.png "icon")
subdirectory. | ![icon](../res/icon/black/ic_subdirectory_arrow_right_black_24dp.png "icon")
text_format. | ![icon](../res/icon/black/ic_text_format_black_24dp.png "icon")
thumb_up. | ![icon](../res/icon/black/ic_thumb_up_black_24dp.png "icon")
timelapse. | ![icon](../res/icon/black/ic_timelapse_black_24dp.png "icon")
timer. | ![icon](../res/icon/black/ic_timer_black_24dp.png "icon")
undo. | ![icon](../res/icon/black/ic_undo_black_24dp.png "icon")
verified. | ![icon](../res/icon/black/ic_verified_user_black_24dp.png "icon")
vibration. | ![icon](../res/icon/black/ic_vibration_black_24dp.png "icon")
listview. | ![icon](../res/icon/black/ic_view_list_black_24dp.png "icon")
visibility. | ![icon](../res/icon/black/ic_visibility_black_24dp.png "icon")
key. | ![icon](../res/icon/black/ic_vpn_key_black_24dp.png "icon")
warning. | ![icon](../res/icon/black/ic_warning_black_24dp.png "icon")
work. | ![icon](../res/icon/black/ic_work_black_24dp.png "icon")
zoom_in. | ![icon](../res/icon/black/ic_zoom_in_black_24dp.png "icon")
zoom_out. | ![icon](../res/icon/black/ic_zoom_out_black_24dp.png "icon")
google_play. | ![icon](../res/icon/black/google_play_black_24dp.png "icon")
back_arrow. | ![icon](../res/icon/black/ic_back_arrow_black_24dp.png "icon")
local_offer. | ![icon](../res/icon/black/ic_local_offer_black_24dp.png "icon")
hd. | ![icon](../res/icon/black/ic_hd_black_24dp.png "icon")
aspect_ratio. | ![icon](../res/icon/black/ic_aspect_ratio_black_24dp.png "icon")
share. | ![icon](../res/icon/black/baseline_share_black_24.png "icon")
