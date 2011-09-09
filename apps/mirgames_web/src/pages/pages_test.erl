-module(pages_test).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("elements.hrl").

main() ->
    #template { file = config:get(default_template_file) }.

title() ->
    "Default page 3".

%% Binding data stored in a simple list.
get_data() -> [
	       ["Title 1", "Author 1", "Description 1", {data, 1}],
	       ["Title 2", "Author 2", "Description 2", {data, 2}],
	       ["Title 3", "Author 3", "Description 3", {data, 3}]
	      ].

get_map() -> 
    %% Binding map is positional...
    [
     titleLabel@text, 
     authorLabel@text, 
     descriptionLabel@text, 
     myButton@postback
    ].

layout() ->
    Data = get_data(),
    Map = get_map(),
    [
     #page_header { text = "Div Binding" },
     #bind {
	   id=simpleBinding,
	   data=Data,
	   map=Map,
	   body=[
		 #hr{},
		 #label { class=tiny, id=titleLabel },
		 #label { class=tiny, id=authorLabel },
		 #label { class=tiny, id=descriptionLabel },
		 #button { class=tiny, id=myButton, text="Button" }
		]}
    ].

event({data, Data}) ->
    Message = "Clicked On Data: " ++ wf:to_list(Data),
    wf:wire(#alert { text = Message }),
    ok;

event(_) -> ok.
