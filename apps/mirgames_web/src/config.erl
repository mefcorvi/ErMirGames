-module(config).
-export([get/1]).

-define(RootDir, "/home/mefcorvi/projects/mirgames/apps/mirgames_web/").
-define(RootDir(Folder), "/home/mefcorvi/projects/mirgames/apps/mirgames_web/" ++ Folder).

get(log4erl_config) ->
    "/home/mefcorvi/projects/mirgames/private/log4erl.conf";

get(docroot) ->
    ?RootDir("static/");

get(default_template_file) ->
    ?RootDir("templates/default.html");

get(data_service_pid) ->
    {data_service, 'mirgames@127.0.0.1'};

get(data_service_timeout) ->
    5000;

get(_) ->
    undefined.
