%-----------------------------------------------

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'EigenFrame'),
	member(Data, List),
	parse_eigenframe_list(Spec, Data.get(tab_list), List),
	parse_eigenframe_is_secure_window(Spec, Data,_),
	parse_eigenframe_script_sources(Spec, Data).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'EigenFragment'),
	member(Data, List),
	parse_eigenframe_url_expand(Spec, Data, List),
	parse_eigenframe_name_sources(Spec, Data), 
	parse_eigenframe_icon_name(Spec, Data,_). 

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'ActionList'),
	member(Data, List),
	parse_eigenframe_comment(Spec, Data,_),
	parse_eigenframe_component_list(Spec, Data, List),
	parse_eigenframe_on_complete(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'AlertDialog'),
	member(Data, List),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_alert_dialog_positive(Spec, Data,_, List),
	parse_eigenframe_alert_dialog_negative(Spec, Data,_, List),
	parse_eigenframe_alert_dialog_neutral(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'Button'),
	member(Data, List),
	parse_eigenframe_text_sources(Spec, Data),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'CheckBox'),
	member(Data, List),
	parse_eigenframe_text_sources(Spec, Data),
	parse_eigenframe_checked(Spec, Data,_),
	parse_eigenframe_id(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'Clone'),
	member(Data, List),
	parse_eigenframe_name(Spec, Data, _),
	parse_eigenframe_attributes(Spec, Data).

% Note: Define component is probably not be a complete parsable eigenframe type.
parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'Define'),
	member(Data, List),
	parse_eigenframe_name(Spec, Data,_),
	X = Data.get(component),
	format(" define-component: ~w~n", [X]).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'EditText'),
	member(Data, List),
	parse_eigenframe_text_sources(Spec, Data),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_ssh_sources(Spec, Data),
	parse_eigenframe_sftp_sources(Spec, Data),
	parse_eigenframe_is_password(Spec, Data,_),
	parse_eigenframe_is_single_line(Spec, Data,_),
	parse_eigenframe_filter(Spec, Data,_),
	parse_eigenframe_id(Spec, Data,_),
	parse_eigenframe_text_color(Spec, Data,_),
	parse_eigenframe_text_size(Spec, Data, _),
	parse_eigenframe_font(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'HorizontalLine'),
	member(Data, List),
	parse_eigenframe_size(Spec, Data,_),
	parse_eigenframe_color(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'HtmlView'),
	member(Data, List),
	parse_eigenframe_html_sources(Spec, Data),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_id(Spec, Data,_),
	parse_eigenframe_text_color(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'ImageView'),
	member(Data, List),
	parse_eigenframe_image_url_sources(Spec, Data),
	parse_eigenframe_rotation(Spec, Data,_),
	parse_eigenframe_id(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'JavaScript'),
	member(Data, List),
	parse_eigenframe_comment(Spec, Data, _),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_script_sources(Spec, Data).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'LinearLayout'),
	member(Data, List),
	parse_eigenframe_scrollable(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_orientation(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_component_list(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'ListView'),
	member(Data, List),
	parse_eigenframe_option_list(Spec, Data,_),
	parse_eigenframe_cached_filename(Spec, Data,_),
	parse_eigenframe_dir_type(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_item_layout(Spec, Data,_),
	parse_eigenframe_checked_option(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'PopupHtmlView'),
	member(Data, List),
	parse_eigenframe_html_sources(Spec, Data),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'PopupScreen'),
	member(Data, List),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_text_size(Spec, Data, _),
	parse_eigenframe_text_color(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_component_list(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'PopupTextView'),
	member(Data, List),
	parse_eigenframe_text_sources(Spec, Data),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_ssh_sources(Spec, Data),
	parse_eigenframe_sftp_sources(Spec, Data),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_text_size(Spec, Data,_),
	parse_eigenframe_text_color(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_font(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'RadioButton'),
	member(Data, List),
	parse_eigenframe_option_list(Spec, Data,_),
	parse_eigenframe_checked_option(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_orientation(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'SecureFtp'),
	member(Data, List),
	parse_eigenframe_sftp_sources(Spec, Data),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_is_eigen_response(Spec, Data,_),
	parse_eigenframe_on_complete(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'SecureShell'),
	member(Data, List),
	parse_eigenframe_ssh_sources(Spec, Data),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_is_eigen_response(Spec, Data,_),
	parse_eigenframe_on_complete(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'SelectDialog'),
	member(Data, List),
	parse_eigenframe_option_list(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_checked_option(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'Spinner'),
	member(Data, List),
	parse_eigenframe_option_list(Spec, Data,_),
	parse_eigenframe_checked_option(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_text_color(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'Switch'),
	member(Data, List),
	parse_eigenframe_text_sources(Spec, Data),
	parse_eigenframe_checked(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_text_color(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'TextView'),
	member(Data, List),
	format(" TextView: ~w~n", [Data]),
	parse_eigenframe_text_sources(Spec, Data),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_ssh_sources(Spec, Data),
	parse_eigenframe_sftp_sources(Spec, Data),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_font(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_text_color(Spec, Data,_),
	parse_eigenframe_text_size(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'ToastMessage'),
	member(Data, List),
	parse_eigenframe_message_script(Spec, Data).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'ToggleButton'),
	member(Data, List),
	parse_eigenframe_text_sources(Spec, Data),
	parse_eigenframe_text_on_sources(Spec, Data),
	parse_eigenframe_text_off_sources(Spec, Data),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_checked(Spec, Data,_),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_margin(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List),
	parse_eigenframe_padding(Spec, Data,_),
	parse_eigenframe_text_color(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'UrlRequest'),
	member(Data, List),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_parameter_list(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_is_eigen_response(Spec, Data,_),
	parse_eigenframe_on_complete(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'Variable'),
	member(Data, List),
	parse_eigenframe_name_sources(Spec, Data),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_method(Spec, Data,_),
	parse_eigenframe_class(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'VerticalLine'),
	member(Data, List),
	parse_eigenframe_size(Spec, Data,_),
	parse_eigenframe_color(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type(Spec, Data, 'WebView'),
	member(Data, List),
	parse_eigenframe_html_sources(Spec, Data),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_is_javascript_enabled(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
 	member(Data, List),
	is_member('Undefined',Spec),
	format(" **************** Undefined Data: ~w~n", [Data]),
	Type = Data.get(type),
	format(" **************** Undefined Type: ~w~n", [Type]),

parse_eigenframe(_, _, _).

% -------------------------------------

parse_eigenframe_list(_, [], _List).
parse_eigenframe_list(Spec, [H|T], List) :-
	format(" ******** parse_eigenframe_list[H]: ~w~n", [H]),
	format(" ******** parse_eigenframe_list[T]: ~w~n", [T]),
	parse_eigenframe(Spec, H, List),						% must always succeed to loop
	format(" ******** parse_eigenframe END: ~n"),
  parse_eigenframe_list(Spec, T, List).

parse_eigenframe_component_list(Spec, Data, List) :- 
	format(" ******** parse_eigenframe_component_list: ~w~n", [Data]),
	X = Data.get(component_list),
	format(" component_list: ~w~n", [X]),
	parse_eigenframe_list(Spec, X, List).
parse_eigenframe_component_list(_, _, _). 

parse_eigenframe_component(Spec, Data, List) :- 
	format(" ******** parse_eigenframe_component: ~w~n", [Data]),
	X = Data.get(component),
	format(" component: ~w~n", [X]),
	parse_eigenframe(Spec, X, List).
parse_eigenframe_component(_, _, _). 

parse_eigenframe_url_expand(Spec, Data, List) :- 
	format(" ******** parse_eigenframe_url_expand: ~w~n", [Data]),
	URL = Data.get(url),
	format(" url: ~w~n", [URL]),
	X = Data.get(is_eigen_response),
	format(" is_eigen_response: ~w~n", [X]),
	X == true,
	read_json_url(URL, Frame),
	parse_eigenframe(Spec, Frame, List).
parse_eigenframe_url_expand(_, _, _). 

parse_eigenframe_on_click(Spec, Data, Frame, List) :- 
	format(" ******** parse_eigenframe_on_click: ~w~n", [Data]),
	Frame = Data.get(on_click),
	format(" on_click: ~w~n", [Frame]),
	parse_eigenframe(Spec, Frame, List).
parse_eigenframe_on_click(_, _, _, _).

parse_eigenframe_on_complete(Spec, Data, List) :- 
	format(" ******** parse_eigenframe_on_complete: ~w~n", [Data]),
	Frame = Data.get(on_complete),
	format(" on_complete: ~w~n", [Frame]),
	parse_eigenframe(Spec, Frame, List).
parse_eigenframe_on_complete(_, _, _).

% -------------------------------------

select_eigenframe_type(Spec, Data, Type) :- 
	is_member(Type, Spec),
	Type == Data.get(type),
	format("= Select eigenframe type: ~w~n", [Type]).

%-----------------------------------------------

parse_eigenframe_attributes(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(attributes),
	format(" attributes: ~w~n", [X]).
parse_eigenframe_attributes(_, _).

%-----------------------------------------------

parse_eigenframe_url(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(url),
	format(" url: ~w~n", [X]).
parse_eigenframe_url(_, _).

parse_eigenframe_url_script(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(url_script),
	format(" url_script: ~w~n", [X]).
parse_eigenframe_url_script(_, _).

parse_eigenframe_url_script_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(url_script_list),
	format(" url_script_list: ~w~n", [X]).
parse_eigenframe_url_script_list(_, _).

parse_eigenframe_url_sources(Spec, Data) :- 
	parse_eigenframe_url(Spec, Data),
	parse_eigenframe_url_script(Spec, Data),
	parse_eigenframe_url_script_list(Spec, Data).

parse_eigenframe_url_sources(_, _).

%-----------------------------------------------

parse_eigenframe_image_url(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(url),
	format(" image_url: ~w~n", [X]).
parse_eigenframe_image_url(_, _).

parse_eigenframe_image_url_script(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(url_script),
	format(" image_url_script: ~w~n", [X]).
parse_eigenframe_image_url_script(_, _).

parse_eigenframe_image_url_script_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(url_script_list),
	format(" image_url_script_list: ~w~n", [X]).
parse_eigenframe_image_url_script_list(_, _).

parse_eigenframe_image_url_sources(Spec, Data) :- 
	parse_eigenframe_image_url(Spec, Data),
	parse_eigenframe_image_url_script(Spec, Data),
	parse_eigenframe_image_url_script_list(Spec, Data).

parse_eigenframe_image_url_sources(_, _).

%-----------------------------------------------

parse_eigenframe_ssh(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(ssh),
	format(" ssh: ~w~n", [X]).
parse_eigenframe_ssh(_, _).

parse_eigenframe_ssh_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(ssh_list),
	format(" ssh_list: ~w~n", [X]).
parse_eigenframe_ssh_list(_, _).

parse_eigenframe_ssh_script(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(ssh_script),
	format(" ssh_script: ~w~n", [X]).
parse_eigenframe_ssh_script(_, _).

parse_eigenframe_ssh_script_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(ssh_script_list),
	format(" ssh_script_list: ~w~n", [X]).
parse_eigenframe_ssh_script_list(_, _).

parse_eigenframe_ssh_sources(Spec, Data) :- 
	parse_eigenframe_ssh(Spec, Data),
	parse_eigenframe_ssh_list(Spec, Data),
	parse_eigenframe_ssh_script(Spec, Data),
	parse_eigenframe_ssh_script_list(Spec, Data).

parse_eigenframe_ssh_sources(_, _).

%-----------------------------------------------

parse_eigenframe_sftp(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(sftp),
	format(" sftp: ~w~n", [X]).
parse_eigenframe_sftp(_, _).

parse_eigenframe_sftp_script(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(sftp_script),
	format(" sftp_script: ~w~n", [X]).
parse_eigenframe_sftp_script(_, _).

parse_eigenframe_sftp_script_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(sftp_script_list),
	format(" sftp_script_list: ~w~n", [X]).
parse_eigenframe_sftp_script_list(_, _).

parse_eigenframe_sftp_sources(Spec, Data) :- 
	parse_eigenframe_sftp(Spec, Data),
	parse_eigenframe_sftp_script(Spec, Data),
	parse_eigenframe_sftp_script_list(Spec, Data).

parse_eigenframe_sftp_sources(_, _). 

%-----------------------------------------------

parse_eigenframe_script(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(script),
	format(" script: ~w~n", [X]).
parse_eigenframe_script(_, _).

parse_eigenframe_script_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(script_list),
	format(" script_list: ~w~n", [X]).
parse_eigenframe_script_list(_, _).

parse_eigenframe_script_sources(Spec, Data) :- 
	parse_eigenframe_script(Spec, Data),
	parse_eigenframe_script_list(Spec, Data).

parse_eigenframe_script_sources(_, _).

%-----------------------------------------------

parse_eigenframe_text(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(text),
	format(" text: ~w~n", [X]).
parse_eigenframe_text(_, _).

parse_eigenframe_text_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_list),
	format(" text_list: ~w~n", [X]).
parse_eigenframe_text_list(_, _).

parse_eigenframe_text_script(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_script),
	format(" text_script: ~w~n", [X]).
parse_eigenframe_text_script(_, _).

parse_eigenframe_text_script_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_script_list),
	format(" text_script_list: ~w~n", [X]).
parse_eigenframe_text_script_list(_, _).

parse_eigenframe_text_sources(Spec, Data) :- 
	parse_eigenframe_text(Spec, Data),
	parse_eigenframe_text_list(Spec, Data),
	parse_eigenframe_text_script(Spec, Data),
	parse_eigenframe_text_script_list(Spec, Data).

parse_eigenframe_text_sources(_, _). 

%-----------------------------------------------

parse_eigenframe_html(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(html),
	format(" html: ~w~n", [X]).
parse_eigenframe_html(_, _).

parse_eigenframe_html_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(html_list),
	format(" html_list: ~w~n", [X]).
parse_eigenframe_html_list(_, _). 

parse_eigenframe_html_script(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(html_script),
	format(" html_script: ~w~n", [X]).
parse_eigenframe_html_script(_, _).

parse_eigenframe_html_script_list(Spec, Data) :- 
	is_member('Verbose',Spec),
	X = Data.get(html_script_list),
	format(" html_script_list: ~w~n", [X]).
parse_eigenframe_html_script_list(_, _).

parse_eigenframe_html_sources(Spec, Data) :- 
	parse_eigenframe_html(Spec, Data),
	parse_eigenframe_html_list(Spec, Data),
	parse_eigenframe_html_script(Spec, Data),
	parse_eigenframe_html_script_list(Spec, Data).

parse_eigenframe_html_sources(_, _).

%-----------------------------------------------

parse_eigenframe_id(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(id),
	format(" id: ~w~n", [X]).
parse_eigenframe_id(_, _, _).

parse_eigenframe_id_script(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(id_script),
	format(" id_script: ~w~n", [X]).
parse_eigenframe_id_script(_, _, _).

parse_eigenframe_id_script_list(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(id_script_list),
	format(" id_script_list: ~w~n", [X]).
parse_eigenframe_id_script_list(_, _, _).

parse_eigenframe_id_sources(Spec, Data) :- 
	parse_eigenframe_id(Spec, Data, _),
	parse_eigenframe_id_script(Spec, Data, _),
	parse_eigenframe_id_script_list(Spec, Data, _).

parse_eigenframe_id_sources(_, _).

%-----------------------------------------------

parse_eigenframe_title(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(title),
	format(" title: ~w~n", [X]).
parse_eigenframe_title(_, _, _). 

parse_eigenframe_title_script(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(title_script),
	format(" title_script: ~w~n", [X]).
parse_eigenframe_title_script(_, _, _). 

parse_eigenframe_title_script_list(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(title_script_list),
	format(" title_script_list: ~w~n", [X]).
parse_eigenframe_title_script_list(_, _, _). 

parse_eigenframe_title_sources(Spec, Data) :- 
	parse_eigenframe_title(Spec, Data, _),
	parse_eigenframe_title_script(Spec, Data, _),
	parse_eigenframe_title_script_list(Spec, Data, _).

parse_eigenframe_title_sources(_, _).

%-----------------------------------------------

parse_eigenframe_name(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(name),
	format(" name: ~w~n", [X]).
parse_eigenframe_name(_, _, _). 

parse_eigenframe_name_script(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(name_script),
	format(" name_script: ~w~n", [X]).
parse_eigenframe_name_script(_, _, _). 

parse_eigenframe_name_script_list(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(name_script_list),
	format(" name_script_list: ~w~n", [X]).
parse_eigenframe_name_script_list(_, _, _). 

parse_eigenframe_name_sources(Spec, Data) :- 
	parse_eigenframe_name(Spec, Data, _),
	parse_eigenframe_name_script(Spec, Data, _),
	parse_eigenframe_name_script_list(Spec, Data, _).

parse_eigenframe_name_sources(_, _).

%-----------------------------------------------

parse_eigenframe_condition(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(condition),
	format(" condition: ~w~n", [X]).
parse_eigenframe_condition(_, _, _). 

parse_eigenframe_condition_script(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(condition_script),
	format(" condition_script: ~w~n", [X]).
parse_eigenframe_condition_script(_, _, _). 

parse_eigenframe_condition_script_list(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(condition_script_list),
	format(" condition_script_list: ~w~n", [X]).
parse_eigenframe_condition_script_list(_, _, _). 

parse_eigenframe_condition_sources(Spec, Data) :- 
	parse_eigenframe_condition(Spec, Data, _),
	parse_eigenframe_condition_script(Spec, Data, _),
	parse_eigenframe_condition_script_list(Spec, Data, _).

parse_eigenframe_condition_sources(_, _). 

%-----------------------------------------------

parse_eigenframe_text_on(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_on),
	format(" text_on: ~w~n", [X]).
parse_eigenframe_text_on(_, _, _). 

parse_eigenframe_text_on_script(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_on_script),
	format(" text_on_script: ~w~n", [X]).
parse_eigenframe_text_on_script(_, _, _). 

parse_eigenframe_text_on_script_list(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_on_script_list),
	format(" text_on_script_list: ~w~n", [X]).
parse_eigenframe_text_on_script_list(_, _, _). 

parse_eigenframe_text_on_sources(Spec, Data) :- 
	parse_eigenframe_text_on(Spec, Data, _),
	parse_eigenframe_text_on_script(Spec, Data, _),
	parse_eigenframe_text_on_script_list(Spec, Data, _).

parse_eigenframe_text_on_sources(_, _). 

%-----------------------------------------------

parse_eigenframe_text_off(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_off),
	format(" text_off: ~w~n", [X]).
parse_eigenframe_text_off(_, _, _). 

parse_eigenframe_text_off_script(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_off_script),
	format(" text_off_script: ~w~n", [X]).
parse_eigenframe_text_off_script(_, _, _). 

parse_eigenframe_text_off_script_list(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_off_script_list),
	format(" text_off_script_list: ~w~n", [X]).
parse_eigenframe_text_off_script_list(_, _, _). 

parse_eigenframe_text_off_sources(Spec, Data) :- 
	parse_eigenframe_text_off(Spec, Data, _),
	parse_eigenframe_text_off_script(Spec, Data, _),
	parse_eigenframe_text_off_script_list(Spec, Data, _).

parse_eigenframe_text_off_sources(_, _).

%-----------------------------------------------

parse_eigenframe_is_secure_window(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(is_secure_window),
	format(" is_secure_window: ~w~n", [X]).
parse_eigenframe_is_secure_window(_, _, _).	

parse_eigenframe_icon_name(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(icon_name),
	format(" icon_name: ~w~n", [X]).
parse_eigenframe_icon_name(_, _, _).	

parse_eigenframe_checked(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(checked),
	format(" checked: ~w~n", [X]).
parse_eigenframe_checked(_, _, _).	

parse_eigenframe_text_color(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_color),
	format(" text_color: ~w~n", [X]).
parse_eigenframe_text_color(_, _, _).	

parse_eigenframe_text_size(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(text_size),
	format(" text_size: ~w~n", [X]).
parse_eigenframe_text_size(_, _, _).	

parse_eigenframe_font(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(font),
	format(" font: ~w~n", [X]).
parse_eigenframe_font(_, _, _).	

parse_eigenframe_layout_width(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(layout_width),
	format(" layout_width: ~w~n", [X]).
parse_eigenframe_layout_width(_, _, _).	

parse_eigenframe_layout_height(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(layout_height),
	format(" layout_height: ~w~n", [X]).
parse_eigenframe_layout_height(_, _, _).	

parse_eigenframe_gravity(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(gravity),
	format(" gravity: ~w~n", [X]).
parse_eigenframe_gravity(_, _, _).	

parse_eigenframe_background_color(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(background_color),
	format(" background_color: ~w~n", [X]).
parse_eigenframe_background_color(_, _, _).	

parse_eigenframe_icon(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(icon),
	format(" icon: ~w~n", [X]).
parse_eigenframe_icon(_, _, _).	

parse_eigenframe_padding(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(padding),
	format(" padding: ~w~n", [X]).
parse_eigenframe_padding(_, _, _).	

parse_eigenframe_margin(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(margin),
	format(" margin: ~w~n", [X]).
parse_eigenframe_margin(_, _, _).	

parse_eigenframe_is_password(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(is_password),
	format(" is_password: ~w~n", [X]).
parse_eigenframe_is_password(_, _, _).	

parse_eigenframe_is_single_line(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(is_single_line),
	format(" is_single_line: ~w~n", [X]).
parse_eigenframe_is_single_line(_, _, _).	

parse_eigenframe_filter(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(filter),
	format(" filter: ~w~n", [X]).
parse_eigenframe_filter(_, _, _).	

parse_eigenframe_size(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(size),
	format(" size: ~w~n", [X]).
parse_eigenframe_size(_, _, _).	

parse_eigenframe_color(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(color),
	format(" color: ~w~n", [X]).
parse_eigenframe_color(_, _, _).	

parse_eigenframe_rotation(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(rotation),
	format(" rotation: ~w~n", [X]).
parse_eigenframe_rotation(_, _, _).	

parse_eigenframe_scrollable(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(scrollable),
	format(" scrollable: ~w~n", [X]).
parse_eigenframe_scrollable(_, _, _).	

parse_eigenframe_orientation(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(orientation),
	format(" orientation: ~w~n", [X]).
parse_eigenframe_orientation(_, _, _).	

parse_eigenframe_option_list(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(option_list),
	format(" option_list: ~w~n", [X]).
parse_eigenframe_option_list(_, _, _).	

parse_eigenframe_item_layout(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(item_layout),
	format(" item_layout: ~w~n", [X]).
parse_eigenframe_item_layout(_, _, _).	

parse_eigenframe_checked_option(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(checked_option),
	format(" checked_option: ~w~n", [X]).
parse_eigenframe_checked_option(_, _, _).	

parse_eigenframe_cached_filename(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(cached_filename),
	format(" cached_filename: ~w~n", [X]).
parse_eigenframe_cached_filename(_, _, _).	

parse_eigenframe_dir_type(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(dir_type),
	format(" dir_type: ~w~n", [X]).
parse_eigenframe_dir_type(_, _, _).	

parse_eigenframe_comment(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(comment),
	format(" comment: ~w~n", [X]).
parse_eigenframe_comment(_, _, _).	

parse_eigenframe_is_eigen_response(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(is_eigen_response),
	format(" is_eigen_response: ~w~n", [X]).
parse_eigenframe_is_eigen_response(_, _, _).	

parse_eigenframe_message_script(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(message_script),
	format(" message_script: ~w~n", [X]).
parse_eigenframe_message_script(_, _, _).	

parse_eigenframe_parameter_list(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(parameter_list),
	format(" parameter_list: ~w~n", [X]).
parse_eigenframe_parameter_list(_, _, _).	

parse_eigenframe_method(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(method),
	format(" method: ~w~n", [X]).
parse_eigenframe_method(_, _, _).	

parse_eigenframe_class(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(class),
	format(" class: ~w~n", [X]).
parse_eigenframe_class(_, _, _).	

parse_eigenframe_is_javascript_enabled(Spec, Data, X) :- 
	is_member('Verbose',Spec),
	X = Data.get(is_javascript_enabled),
	format(" is_javascript_enabled: ~w~n", [X]).
parse_eigenframe_is_javascript_enabled(_, _, _).	

parse_eigenframe_alert_dialog_positive(Spec, Data, X, List) :- 
	is_member('Verbose',Spec),
	X = Data.get(positive),
	parse_eigenframe_on_click(Spec, X, _, List),
 	format(" positive: ~w~n", [X]).
parse_eigenframe_alert_dialog_positive(_, _, _, _).	

parse_eigenframe_alert_dialog_negative(Spec, Data, X, List) :- 
	is_member('Verbose',Spec),
	X = Data.get(negative),
	parse_eigenframe_on_click(Spec, X, _, List),
 	format(" negative: ~w~n", [X]).
parse_eigenframe_alert_dialog_negative(_, _, _, _).	

parse_eigenframe_alert_dialog_neutral(Spec, Data, X, List) :- 
	is_member('Verbose',Spec),
	X = Data.get(neutral),
	parse_eigenframe_on_click(Spec, X, _, List),
 	format(" neutral: ~w~n", [X]).
parse_eigenframe_alert_dialog_neutral(_, _, _, _).	

