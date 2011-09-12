-module(mirgames_data_service).
-behaviour(gen_server).
-include("server.hrl").

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	 terminate/2, code_change/3]).

-record(state, {
	  db :: any()
	 }).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
    gen_server:start_link({local, data_service}, ?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    couchbeam:start(),
    Server = couchbeam:server_connection(server_config:get(db_host), server_config:get(db_port)),
    {ok, Db} = couchbeam:open_or_create_db(Server, server_config:get(db_name)),
    {ok, #state{db=Db}}.

handle_call(#command{}=Command, _From, #state{db=Db}=State) ->
    io:format("Received command ~w~n", [Command]),
    CommandName = list_to_atom(string:concat("command_", atom_to_list(Command#command.name))),
    CommandName:handle(Command, Db),
    {reply, {event, test_event, []}, State};

handle_call(Request, _From, State) ->
    Reply = {wrong_request, Request},
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
