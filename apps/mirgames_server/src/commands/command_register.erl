-module(command_register).
-export([handle/2]).

handle(Command, Db) ->
    couchbeam:save_doc(Db, {[
			     {<<"_id">>, <<"myid">>},
			     {<<"title">>, <<"Test">>}
			    ]}).
