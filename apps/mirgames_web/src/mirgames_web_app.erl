-module(mirgames_web_app).

-behaviour(application).
-include("log.hrl").

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    application:start(nprocreg),
    start_logger(),
    ?Log("Starting mirgames web application..."),
    mirgames_web_sup:start_link().

start_logger() ->
    application:start(log4erl),
    error_logger:delete_report_handler(error_logger),
    error_logger:tty(false),
    log4erl:conf(config:get(log4erl_config)),
    log4erl:error_logger_handler().

stop(_State) ->
    ok.
