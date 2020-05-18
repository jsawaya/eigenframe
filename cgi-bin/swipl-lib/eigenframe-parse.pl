verbose_format(Spec, Format, X) :- 
	is_member('Verbose',Spec),
 	format(Format, [X]).
verbose_format(_, _, _).

%-----------------------------------------------

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('EigenFrame', Spec, Data, List),
	parse_eigenframe_is_secure_window(Spec, Data,_),
	parse_eigenframe_script_sources(Spec, Data),
	parse_eigenframe_list(Spec, Data.get(tab_list), List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('EigenFragment', Spec, Data, List),
	parse_eigenframe_name_sources(Spec, Data), 
	parse_eigenframe_icon_name(Spec, Data,_),
	parse_eigenframe_eigenfragment_url(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('ActionList', Spec, Data, List),
	parse_eigenframe_comment(Spec, Data,_),
	parse_eigenframe_component_list(Spec, Data, List),
	parse_eigenframe_on_complete(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('AlertDialog', Spec, Data, List),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_alert_dialog_positive(Spec, Data,_, List),
	parse_eigenframe_alert_dialog_negative(Spec, Data,_, List),
	parse_eigenframe_alert_dialog_neutral(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('Button', Spec, Data, List),
	parse_eigenframe_text_sources(Spec, Data),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('CheckBox', Spec, Data, List),
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
	select_eigenframe_type('Clone', Spec, Data, List),
	parse_eigenframe_name(Spec, Data, _),
	parse_eigenframe_attributes(Spec, Data).

% Note: Define component is rarely a complete parsable eigenframe type.
parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('Define', Spec, Data, List),
	parse_eigenframe_name(Spec, Data, Define_name),
	Component = Data.get(component),
	define_component(Define_name, Component).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('EditText', Spec, Data, List),
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
	select_eigenframe_type('HorizontalLine', Spec, Data, List),
	parse_eigenframe_size(Spec, Data,_),
	parse_eigenframe_color(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('HtmlView', Spec, Data, List),
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
	select_eigenframe_type('ImageView', Spec, Data, List),
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
	select_eigenframe_type('JavaScript', Spec, Data, List),
	parse_eigenframe_comment(Spec, Data, _),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_script_sources(Spec, Data).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('LinearLayout', Spec, Data, List),
	parse_eigenframe_scrollable(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_orientation(Spec, Data,_),
	parse_eigenframe_gravity(Spec, Data,_),
	parse_eigenframe_component_list(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('ListView', Spec, Data, List),
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
	select_eigenframe_type('PopupHtmlView', Spec, Data, List),
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
	select_eigenframe_type('PopupScreen', Spec, Data, List),
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
	select_eigenframe_type('PopupTextView', Spec, Data, List),
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
	select_eigenframe_type('RadioButton', Spec, Data, List),
	parse_eigenframe_option_list(Spec, Data,_),
	parse_eigenframe_checked_option(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_orientation(Spec, Data,_),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_background_color(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('SecureFtp', Spec, Data, List),
	parse_eigenframe_sftp_sources(Spec, Data),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_is_eigen_response(Spec, Data,_),
	parse_eigenframe_on_complete(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('SecureShell', Spec, Data, List),
	parse_eigenframe_ssh_sources(Spec, Data),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_is_eigen_response(Spec, Data,_),
	parse_eigenframe_on_complete(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('SelectDialog', Spec, Data, List),
	parse_eigenframe_option_list(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_icon(Spec, Data,_),
	parse_eigenframe_checked_option(Spec, Data,_),
	parse_eigenframe_on_click(Spec, Data,_, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('Spinner', Spec, Data, List),
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
	select_eigenframe_type('Switch', Spec, Data, List),
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
	select_eigenframe_type('TextView', Spec, Data, List),
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
	select_eigenframe_type('ToastMessage', Spec, Data, List),
	parse_eigenframe_message_script(Spec, Data).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('ToggleButton', Spec, Data, List),
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
	select_eigenframe_type('UrlRequest', Spec, Data, List),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_parameter_list(Spec, Data,_),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_is_eigen_response(Spec, Data,_),
	parse_eigenframe_on_complete(Spec, Data, List).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('Variable', Spec, Data, List),
	parse_eigenframe_name_sources(Spec, Data),
	parse_eigenframe_id_sources(Spec, Data),
	parse_eigenframe_method(Spec, Data,_),
	parse_eigenframe_class(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('VerticalLine', Spec, Data, List),
	parse_eigenframe_size(Spec, Data,_),
	parse_eigenframe_color(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	select_eigenframe_type('WebView', Spec, Data, List),
	parse_eigenframe_html_sources(Spec, Data),
	parse_eigenframe_url_sources(Spec, Data),
	parse_eigenframe_title_sources(Spec, Data),
	parse_eigenframe_layout_width(Spec, Data,_),
	parse_eigenframe_layout_height(Spec, Data,_),
	parse_eigenframe_is_javascript_enabled(Spec, Data,_).

parse_eigenframe(Spec, Data, List) :- 
	is_member('Undefined',Spec),
 	member(Data, List),
	format(" **************** Undefined Data: ~w~n", [Data]).

parse_eigenframe(_, _, _).

% -------------------------------------

select_eigenframe_type(Type, Spec, Data, List) :- 
	is_member(Type, Spec),
	Type == Data.get(type),
	member(Data, List),
	verbose_format(Spec, "= Select eigenframe type: ~w~n", Type).

% -------------------------------------

parse_eigenframe_list(_, [], _List).
parse_eigenframe_list(Spec, [H|T], List) :-
%	format(" ******** parse_eigenframe_list[H]: ~w~n", [H]),
	parse_eigenframe(Spec, H, List),						% must always succeed to loop
%	format(" ******** parse_eigenframe END: ~n"),
  parse_eigenframe_list(Spec, T, List).

parse_eigenframe_component_list(Spec, Data, List) :- 
	X = Data.get(component_list),
	verbose_format(Spec, " component_list: ~w~n", X),
	parse_eigenframe_list(Spec, X, List).
parse_eigenframe_component_list(_, _, _). 

parse_eigenframe_component(Spec, Data, List) :- 
	X = Data.get(component),
	verbose_format(Spec, " component: ~w~n", X),
	parse_eigenframe(Spec, X, List).
parse_eigenframe_component(_, _, _). 

parse_eigenframe_eigenfragment_url(Spec, Data, List) :- 
	URL = Data.get(url),
	verbose_format(Spec, " url: ~w~n", URL),
	read_json_url(URL, Frame),
	parse_eigenframe(Spec, Frame, List).

parse_eigenframe_url_expand(Spec, Data, List) :- 
	URL = Data.get(url),
	verbose_format(Spec, " url: ~w~n", URL),
	X = Data.get(is_eigen_response),
	verbose_format(Spec, " is_eigen_response: ~w~n", X),
	X == true,
	read_json_url(URL, Frame),
	parse_eigenframe(Spec, Frame, List).
parse_eigenframe_url_expand(_, _, _). 

parse_eigenframe_on_click(Spec, Data, X, List) :- 
	X = Data.get(on_click),
	verbose_format(Spec, " on_click: ~w~n", X),
	parse_eigenframe(Spec, X, List).
parse_eigenframe_on_click(_, _, _, _).

parse_eigenframe_on_complete(Spec, Data, List) :- 
	X = Data.get(on_complete),
	verbose_format(Spec, " on_complete: ~w~n", X),
	parse_eigenframe(Spec, X, List).

parse_eigenframe_on_complete(_, _, _).

%-----------------------------------------------

parse_eigenframe_attributes(Spec, Data) :- 
	X = Data.get(attributes),
	verbose_format(Spec, " attributes: ~w~n", X).
parse_eigenframe_attributes(_, _).

%-----------------------------------------------

parse_eigenframe_url(Spec, Data) :- 
	X = Data.get(url),
	verbose_format(Spec, " url: ~w~n", X).
parse_eigenframe_url(_, _).

parse_eigenframe_url_script(Spec, Data) :- 
	X = Data.get(url_script),
	verbose_format(Spec, " url_script: ~w~n", X).
parse_eigenframe_url_script(_, _).

parse_eigenframe_url_script_list(Spec, Data) :- 
	X = Data.get(url_script_list),
	verbose_format(Spec, " url_script_list: ~w~n", X).
parse_eigenframe_url_script_list(_, _).

parse_eigenframe_url_sources(Spec, Data) :- 
	parse_eigenframe_url(Spec, Data),
	parse_eigenframe_url_script(Spec, Data),
	parse_eigenframe_url_script_list(Spec, Data).

parse_eigenframe_url_sources(_, _).

%-----------------------------------------------

parse_eigenframe_image_url(Spec, Data) :- 
	X = Data.get(url),
	verbose_format(Spec, " image_url: ~w~n", X).
parse_eigenframe_image_url(_, _).

parse_eigenframe_image_url_script(Spec, Data) :- 
	X = Data.get(url_script),
	verbose_format(Spec, " image_url_script: ~w~n", X).
parse_eigenframe_image_url_script(_, _).

parse_eigenframe_image_url_script_list(Spec, Data) :- 
	X = Data.get(url_script_list),
	verbose_format(Spec, " image_url_script_list: ~w~n", X).
parse_eigenframe_image_url_script_list(_, _).

parse_eigenframe_image_url_sources(Spec, Data) :- 
	parse_eigenframe_image_url(Spec, Data),
	parse_eigenframe_image_url_script(Spec, Data),
	parse_eigenframe_image_url_script_list(Spec, Data).

parse_eigenframe_image_url_sources(_, _).

%-----------------------------------------------

parse_eigenframe_ssh(Spec, Data) :- 
	X = Data.get(ssh),
	verbose_format(Spec, " ssh: ~w~n", X).
parse_eigenframe_ssh(_, _).

parse_eigenframe_ssh_list(Spec, Data) :- 
	X = Data.get(ssh_list),
	verbose_format(Spec, " ssh_list: ~w~n", X).
parse_eigenframe_ssh_list(_, _).

parse_eigenframe_ssh_script(Spec, Data) :- 
	X = Data.get(ssh_script),
	verbose_format(Spec, " ssh_script: ~w~n", X).
parse_eigenframe_ssh_script(_, _).

parse_eigenframe_ssh_script_list(Spec, Data) :- 
	X = Data.get(ssh_script_list),
	verbose_format(Spec, " ssh_script_list: ~w~n", X).
parse_eigenframe_ssh_script_list(_, _).

parse_eigenframe_ssh_sources(Spec, Data) :- 
	parse_eigenframe_ssh(Spec, Data),
	parse_eigenframe_ssh_list(Spec, Data),
	parse_eigenframe_ssh_script(Spec, Data),
	parse_eigenframe_ssh_script_list(Spec, Data).

parse_eigenframe_ssh_sources(_, _).

%-----------------------------------------------

parse_eigenframe_sftp(Spec, Data) :- 
	X = Data.get(sftp),
	verbose_format(Spec, " sftp: ~w~n", X).
parse_eigenframe_sftp(_, _).

parse_eigenframe_sftp_script(Spec, Data) :- 
	X = Data.get(sftp_script),
	verbose_format(Spec, " sftp_script: ~w~n", X).
parse_eigenframe_sftp_script(_, _).

parse_eigenframe_sftp_script_list(Spec, Data) :- 
	X = Data.get(sftp_script_list),
	verbose_format(Spec, " sftp_script_list: ~w~n", X).
parse_eigenframe_sftp_script_list(_, _).

parse_eigenframe_sftp_sources(Spec, Data) :- 
	parse_eigenframe_sftp(Spec, Data),
	parse_eigenframe_sftp_script(Spec, Data),
	parse_eigenframe_sftp_script_list(Spec, Data).

parse_eigenframe_sftp_sources(_, _). 

%-----------------------------------------------

parse_eigenframe_script_script(Spec, Data) :- 
	X = Data.get(script_script),
	verbose_format(Spec, " script_script: ~w~n", X).
parse_eigenframe_script_script(_, _).

parse_eigenframe_script(Spec, Data) :- 
	X = Data.get(script),
	verbose_format(Spec, " script: ~w~n", X).
parse_eigenframe_script(_, _).

parse_eigenframe_script_list(Spec, Data) :- 
	X = Data.get(script_list),
	verbose_format(Spec, " script_list: ~w~n", X).
parse_eigenframe_script_list(_, _).

parse_eigenframe_script_sources(Spec, Data) :- 
	parse_eigenframe_script_script(Spec, Data),
	parse_eigenframe_script(Spec, Data),
	parse_eigenframe_script_list(Spec, Data).

parse_eigenframe_script_sources(_, _).

%-----------------------------------------------

parse_eigenframe_text(Spec, Data) :- 
	X = Data.get(text),
	verbose_format(Spec, " text: ~w~n", X).
parse_eigenframe_text(_, _).

parse_eigenframe_text_list(Spec, Data) :- 
	X = Data.get(text_list),
	verbose_format(Spec, " text_list: ~w~n", X).
parse_eigenframe_text_list(_, _).

parse_eigenframe_text_script(Spec, Data) :- 
	X = Data.get(text_script),
	verbose_format(Spec, " text_script: ~w~n", X).
parse_eigenframe_text_script(_, _).

parse_eigenframe_text_script_list(Spec, Data) :- 
	X = Data.get(text_script_list),
	verbose_format(Spec, " text_script_list: ~w~n", X).
parse_eigenframe_text_script_list(_, _).

parse_eigenframe_text_sources(Spec, Data) :- 
	parse_eigenframe_text(Spec, Data),
	parse_eigenframe_text_list(Spec, Data),
	parse_eigenframe_text_script(Spec, Data),
	parse_eigenframe_text_script_list(Spec, Data).

parse_eigenframe_text_sources(_, _). 

%-----------------------------------------------

parse_eigenframe_html(Spec, Data) :- 
	X = Data.get(html),
	verbose_format(Spec, " html: ~w~n", X).
parse_eigenframe_html(_, _).

parse_eigenframe_html_list(Spec, Data) :- 
	X = Data.get(html_list),
	verbose_format(Spec, " html_list: ~w~n", X).
parse_eigenframe_html_list(_, _). 

parse_eigenframe_html_script(Spec, Data) :- 
	X = Data.get(html_script),
	verbose_format(Spec, " html_script: ~w~n", X).
parse_eigenframe_html_script(_, _).

parse_eigenframe_html_script_list(Spec, Data) :- 
	X = Data.get(html_script_list),
	verbose_format(Spec, " html_script_list: ~w~n", X).
parse_eigenframe_html_script_list(_, _).

parse_eigenframe_html_sources(Spec, Data) :- 
	parse_eigenframe_html(Spec, Data),
	parse_eigenframe_html_list(Spec, Data),
	parse_eigenframe_html_script(Spec, Data),
	parse_eigenframe_html_script_list(Spec, Data).

parse_eigenframe_html_sources(_, _).

%-----------------------------------------------

parse_eigenframe_id(Spec, Data, X) :- 
	X = Data.get(id),
	verbose_format(Spec, " id: ~w~n", X).
parse_eigenframe_id(_, _, _).

parse_eigenframe_id_script(Spec, Data, X) :- 
	X = Data.get(id_script),
	verbose_format(Spec, " id_script: ~w~n", X).
parse_eigenframe_id_script(_, _, _).

parse_eigenframe_id_script_list(Spec, Data, X) :- 
	X = Data.get(id_script_list),
	verbose_format(Spec, " id_script_list: ~w~n", X).
parse_eigenframe_id_script_list(_, _, _).

parse_eigenframe_id_sources(Spec, Data) :- 
	parse_eigenframe_id(Spec, Data, _),
	parse_eigenframe_id_script(Spec, Data, _),
	parse_eigenframe_id_script_list(Spec, Data, _).

parse_eigenframe_id_sources(_, _).

%-----------------------------------------------

parse_eigenframe_title(Spec, Data, X) :- 
	X = Data.get(title),
	verbose_format(Spec, " title: ~w~n", X).
parse_eigenframe_title(_, _, _). 

parse_eigenframe_title_script(Spec, Data, X) :- 
	X = Data.get(title_script),
	verbose_format(Spec, " title_script: ~w~n", X).
parse_eigenframe_title_script(_, _, _). 

parse_eigenframe_title_script_list(Spec, Data, X) :- 
	X = Data.get(title_script_list),
	verbose_format(Spec, " title_script_list: ~w~n", X).
parse_eigenframe_title_script_list(_, _, _). 

parse_eigenframe_title_sources(Spec, Data) :- 
	parse_eigenframe_title(Spec, Data, _),
	parse_eigenframe_title_script(Spec, Data, _),
	parse_eigenframe_title_script_list(Spec, Data, _).

parse_eigenframe_title_sources(_, _).

%-----------------------------------------------

parse_eigenframe_name(Spec, Data, X) :- 
	X = Data.get(name),
	verbose_format(Spec, " name: ~w~n", X).
parse_eigenframe_name(_, _, _). 

parse_eigenframe_name_script(Spec, Data, X) :- 
	X = Data.get(name_script),
	verbose_format(Spec, " name_script: ~w~n", X).
parse_eigenframe_name_script(_, _, _). 

parse_eigenframe_name_script_list(Spec, Data, X) :- 
	X = Data.get(name_script_list),
	verbose_format(Spec, " name_script_list: ~w~n", X).
parse_eigenframe_name_script_list(_, _, _). 

parse_eigenframe_name_sources(Spec, Data) :- 
	parse_eigenframe_name(Spec, Data, _),
	parse_eigenframe_name_script(Spec, Data, _),
	parse_eigenframe_name_script_list(Spec, Data, _).

parse_eigenframe_name_sources(_, _).

%-----------------------------------------------

parse_eigenframe_condition(Spec, Data, X) :- 
	X = Data.get(condition),
	verbose_format(Spec, " condition: ~w~n", X).
parse_eigenframe_condition(_, _, _). 

parse_eigenframe_condition_script(Spec, Data, X) :- 
	X = Data.get(condition_script),
	verbose_format(Spec, " condition_script: ~w~n", X).
parse_eigenframe_condition_script(_, _, _). 

parse_eigenframe_condition_script_list(Spec, Data, X) :- 
	X = Data.get(condition_script_list),
	verbose_format(Spec, " condition_script_list: ~w~n", X).
parse_eigenframe_condition_script_list(_, _, _). 

parse_eigenframe_condition_sources(Spec, Data) :- 
	parse_eigenframe_condition(Spec, Data, _),
	parse_eigenframe_condition_script(Spec, Data, _),
	parse_eigenframe_condition_script_list(Spec, Data, _).

parse_eigenframe_condition_sources(_, _). 

%-----------------------------------------------

parse_eigenframe_text_on(Spec, Data, X) :- 
	X = Data.get(text_on),
	verbose_format(Spec, " text_on: ~w~n", X).
parse_eigenframe_text_on(_, _, _). 

parse_eigenframe_text_on_script(Spec, Data, X) :- 
	X = Data.get(text_on_script),
	verbose_format(Spec, " text_on_script: ~w~n", X).
parse_eigenframe_text_on_script(_, _, _). 

parse_eigenframe_text_on_script_list(Spec, Data, X) :- 
	X = Data.get(text_on_script_list),
	verbose_format(Spec, " text_on_script_list: ~w~n", X).
parse_eigenframe_text_on_script_list(_, _, _). 

parse_eigenframe_text_on_sources(Spec, Data) :- 
	parse_eigenframe_text_on(Spec, Data, _),
	parse_eigenframe_text_on_script(Spec, Data, _),
	parse_eigenframe_text_on_script_list(Spec, Data, _).

parse_eigenframe_text_on_sources(_, _). 

%-----------------------------------------------

parse_eigenframe_text_off(Spec, Data, X) :- 
	X = Data.get(text_off),
	verbose_format(Spec, " text_off: ~w~n", X).
parse_eigenframe_text_off(_, _, _). 

parse_eigenframe_text_off_script(Spec, Data, X) :- 
	X = Data.get(text_off_script),
	verbose_format(Spec, " text_off_script: ~w~n", X).
parse_eigenframe_text_off_script(_, _, _). 

parse_eigenframe_text_off_script_list(Spec, Data, X) :- 
	X = Data.get(text_off_script_list),
	verbose_format(Spec, " text_off_script_list: ~w~n", X).
parse_eigenframe_text_off_script_list(_, _, _). 

parse_eigenframe_text_off_sources(Spec, Data) :- 
	parse_eigenframe_text_off(Spec, Data, _),
	parse_eigenframe_text_off_script(Spec, Data, _),
	parse_eigenframe_text_off_script_list(Spec, Data, _).

parse_eigenframe_text_off_sources(_, _).

%-----------------------------------------------

parse_eigenframe_is_secure_window(Spec, Data, X) :- 
	X = Data.get(is_secure_window),
	verbose_format(Spec, " is_secure_window: ~w~n", X).
parse_eigenframe_is_secure_window(_, _, _).	

parse_eigenframe_icon_name(Spec, Data, X) :- 
	X = Data.get(icon_name),
	verbose_format(Spec, " icon_name: ~w~n", X).
parse_eigenframe_icon_name(_, _, _).	

parse_eigenframe_checked(Spec, Data, X) :- 
	X = Data.get(checked),
	verbose_format(Spec, " checked: ~w~n", X).
parse_eigenframe_checked(_, _, _).	

parse_eigenframe_text_color(Spec, Data, X) :- 
	X = Data.get(text_color),
	verbose_format(Spec, " text_color: ~w~n", X).
parse_eigenframe_text_color(_, _, _).	

parse_eigenframe_text_size(Spec, Data, X) :- 
	X = Data.get(text_size),
	verbose_format(Spec, " text_size: ~w~n", X).
parse_eigenframe_text_size(_, _, _).	

parse_eigenframe_font(Spec, Data, X) :- 
	X = Data.get(font),
	verbose_format(Spec, " font: ~w~n", X).
parse_eigenframe_font(_, _, _).	

parse_eigenframe_layout_width(Spec, Data, X) :- 
	X = Data.get(layout_width),
	verbose_format(Spec, " layout_width: ~w~n", X).
parse_eigenframe_layout_width(_, _, _).	

parse_eigenframe_layout_height(Spec, Data, X) :- 
	X = Data.get(layout_height),
	verbose_format(Spec, " layout_height: ~w~n", X).
parse_eigenframe_layout_height(_, _, _).	

parse_eigenframe_gravity(Spec, Data, X) :- 
	X = Data.get(gravity),
	verbose_format(Spec, " gravity: ~w~n", X).
parse_eigenframe_gravity(_, _, _).	

parse_eigenframe_background_color(Spec, Data, X) :- 
	X = Data.get(background_color),
	verbose_format(Spec, " background_color: ~w~n", X).
parse_eigenframe_background_color(_, _, _).	

parse_eigenframe_icon(Spec, Data, X) :- 
	X = Data.get(icon),
	verbose_format(Spec, " icon: ~w~n", X).
parse_eigenframe_icon(_, _, _).	

parse_eigenframe_padding(Spec, Data, X) :- 
	X = Data.get(padding),
	verbose_format(Spec, " padding: ~w~n", X).
parse_eigenframe_padding(_, _, _).	

parse_eigenframe_margin(Spec, Data, X) :- 
	X = Data.get(margin),
	verbose_format(Spec, " margin: ~w~n", X).
parse_eigenframe_margin(_, _, _).	

parse_eigenframe_is_password(Spec, Data, X) :- 
	X = Data.get(is_password),
	verbose_format(Spec, " is_password: ~w~n", X).
parse_eigenframe_is_password(_, _, _).	

parse_eigenframe_is_single_line(Spec, Data, X) :- 
	X = Data.get(is_single_line),
	verbose_format(Spec, " is_single_line: ~w~n", X).
parse_eigenframe_is_single_line(_, _, _).	

parse_eigenframe_filter(Spec, Data, X) :- 
	X = Data.get(filter),
	verbose_format(Spec, " filter: ~w~n", X).
parse_eigenframe_filter(_, _, _).	

parse_eigenframe_size(Spec, Data, X) :- 
	X = Data.get(size),
	verbose_format(Spec, " size: ~w~n", X).
parse_eigenframe_size(_, _, _).	

parse_eigenframe_color(Spec, Data, X) :- 
	X = Data.get(color),
	verbose_format(Spec, " color: ~w~n", X).
parse_eigenframe_color(_, _, _).	

parse_eigenframe_rotation(Spec, Data, X) :- 
	X = Data.get(rotation),
	verbose_format(Spec, " rotation: ~w~n", X).
parse_eigenframe_rotation(_, _, _).	

parse_eigenframe_scrollable(Spec, Data, X) :- 
	X = Data.get(scrollable),
	verbose_format(Spec, " scrollable: ~w~n", X).
parse_eigenframe_scrollable(_, _, _).	

parse_eigenframe_orientation(Spec, Data, X) :- 
	X = Data.get(orientation),
	verbose_format(Spec, " orientation: ~w~n", X).
parse_eigenframe_orientation(_, _, _).	

parse_eigenframe_option_list(Spec, Data, X) :- 
	X = Data.get(option_list),
	verbose_format(Spec, " option_list: ~w~n", X).
parse_eigenframe_option_list(_, _, _).	

parse_eigenframe_item_layout(Spec, Data, X) :- 
	X = Data.get(item_layout),
	verbose_format(Spec, " item_layout: ~w~n", X).
parse_eigenframe_item_layout(_, _, _).	

parse_eigenframe_checked_option(Spec, Data, X) :- 
	X = Data.get(checked_option),
	verbose_format(Spec, " checked_option: ~w~n", X).
parse_eigenframe_checked_option(_, _, _).	

parse_eigenframe_cached_filename(Spec, Data, X) :- 
	X = Data.get(cached_filename),
	verbose_format(Spec, " cached_filename: ~w~n", X).
parse_eigenframe_cached_filename(_, _, _).	

parse_eigenframe_dir_type(Spec, Data, X) :- 
	X = Data.get(dir_type),
	verbose_format(Spec, " dir_type: ~w~n", X).
parse_eigenframe_dir_type(_, _, _).	

parse_eigenframe_comment(Spec, Data, X) :- 
	X = Data.get(comment),
	verbose_format(Spec, " comment: ~w~n", X).
parse_eigenframe_comment(_, _, _).	

parse_eigenframe_is_eigen_response(Spec, Data, X) :- 
	X = Data.get(is_eigen_response),
	verbose_format(Spec, " is_eigen_response: ~w~n", X).
parse_eigenframe_is_eigen_response(_, _, _).	

parse_eigenframe_message_script(Spec, Data, X) :- 
	X = Data.get(message_script),
	verbose_format(Spec, " message_script: ~w~n", X).
parse_eigenframe_message_script(_, _, _).	

parse_eigenframe_parameter_list(Spec, Data, X) :- 
	X = Data.get(parameter_list),
	verbose_format(Spec, " parameter_list: ~w~n", X).
parse_eigenframe_parameter_list(_, _, _).	

parse_eigenframe_method(Spec, Data, X) :- 
	X = Data.get(method),
	verbose_format(Spec, " method: ~w~n", X).
parse_eigenframe_method(_, _, _).	

parse_eigenframe_class(Spec, Data, X) :- 
	X = Data.get(class),
	verbose_format(Spec, " class: ~w~n", X).
parse_eigenframe_class(_, _, _).	

parse_eigenframe_is_javascript_enabled(Spec, Data, X) :- 
	X = Data.get(is_javascript_enabled),
	verbose_format(Spec, " is_javascript_enabled: ~w~n", X).
parse_eigenframe_is_javascript_enabled(_, _, _).	

parse_eigenframe_alert_dialog_positive(Spec, Data, X, List) :- 
	X = Data.get(positive),
	verbose_format(Spec, " positive: ~w~n", X),
	parse_eigenframe_on_click(Spec, X, _, List).
parse_eigenframe_alert_dialog_positive(_, _, _, _).	

parse_eigenframe_alert_dialog_negative(Spec, Data, X, List) :- 
	X = Data.get(negative),
	verbose_format(Spec, " negative: ~w~n", X),
	parse_eigenframe_on_click(Spec, X, _, List).
parse_eigenframe_alert_dialog_negative(_, _, _, _).	

parse_eigenframe_alert_dialog_neutral(Spec, Data, X, List) :- 
	X = Data.get(neutral),
	verbose_format(Spec, " neutral: ~w~n", X),
	parse_eigenframe_on_click(Spec, X, _, List).
parse_eigenframe_alert_dialog_neutral(_, _, _, _).	

