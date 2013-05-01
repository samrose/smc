-module(security_lib).
-export([logged_in/1]).

logged_in(SessionID) ->
    case boss_session:get_session_data(SessionID, participant_id) of
        undefined ->
	    error_logger:warn_msg("Not logged in, redirecting~n"),
            {redirect, [{controller, "security"}, {action,"login"}]};
	ParticipantId ->
	    Participant = boss_db:find(ParticipantId),
	    error_logger:info_msg("SessionID: ~p~nParticipant: ~p~n", [SessionID, Participant]),
	    {ok, Participant}
    end.
