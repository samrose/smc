-module(smc_profile_controller, [Req, SessionID]).
-compile([export_all]).
before_(_) ->
  security_lib:logged_in(SessionID).
show('GET', [Id]) ->
	Participant = boss_db:find(Id),
        %% Wics = Agent:getmembers(),
	%%Groups = [boss_db:find(X) || X <- Agent:memberships()],
	%%error_logger:info_msg("Agent: ~p~nWics: ~p~n", [Agent, Groups]),
	%%{ok, [{agent, Agent}, {wics, Groups}]}.
	{ok, [{participant, Participant}]}.
