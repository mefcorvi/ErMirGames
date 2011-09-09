.PHONY: all compile release test doc

all: compile

compile:
	@[ -f private/game_log.log ] && rm private/game_log.log || echo "Log file not exists"
	@rm -f apps/mirgames_web/static/nitrogen
	@ln -sf ../../../deps/nitrogen_core/www apps/mirgames_web/static/nitrogen
	rebar skip_deps=true compile

release: compile
	rebar -f generate

test:
	rebar skip_deps=true eunit

run:
	@echo "Running..."
	@erl -pa ebin ./apps/*/ebin ./deps/*/include \
	./deps/*/ebin .deps/*/include \
	-name mirgames@127.0.0.1 \
	-eval "application:start(misultin), application:start(mirgames_server), application:start(mirgames_web), sync:go()."

doc:
	set -v off
	rebar doc
