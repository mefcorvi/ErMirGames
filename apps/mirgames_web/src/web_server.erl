-module(web_server).
-export([start/1, stop/0]).

start(Port) ->
    misultin:start_link([{port, Port}, {loop, fun(Req) -> handle_http(Req) end}]).

stop() ->
    misultin:stop().

handle_http(Req) ->
    ReqBridge = simple_bridge:make_request(mirgames_request_bridge, Req),
    RespBridge = simple_bridge:make_response(mirgames_response_bridge, Req),
    nitrogen:init_request(ReqBridge, RespBridge),
    nitrogen:run().
