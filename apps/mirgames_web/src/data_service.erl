-module(data_service).
-export([send_command/2, receive_event/1]).

send_command(Name, Args) when is_atom(Name) ->
    gen_server:call(config:get(data_service_pid), {command, Name, Args}).

receive_event(EventType) ->
    DataServicePid = config:get(data_service_pid),
    TimeOut = config:get(data_service_timeout),
    receive
	{DataServicePid, event, EventType, EventData} ->
	    EventData
    after TimeOut ->
	    {error, timeout_experied}
    end.
