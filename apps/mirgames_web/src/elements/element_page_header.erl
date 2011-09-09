-module(element_page_header).
-include("elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() ->
    record_info(fields, page_header).

render_element(Record) ->
    Body = [
	    Record#page_header.text
	   ],
    wf_tags:emit_tag('div', Body, [{class, "test"}]).
