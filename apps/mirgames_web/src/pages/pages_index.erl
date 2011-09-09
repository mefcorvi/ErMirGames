-module(pages_index).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").

main() ->
    #h1 { text = "Hello world!" }.
