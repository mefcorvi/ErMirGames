-module(mirgames_server_app).
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    io:format("Starting mirgames_server..."),
    mirgames_server_sup:start_link().

stop(_State) ->
    ok.

