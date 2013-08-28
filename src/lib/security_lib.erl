-module(security_lib).
-export([logged_in/1,classroom_member/2]).
logged_in(SessionID) ->
    case boss_session:get_session_data(SessionID, participant_id) of
        undefined ->
	    error_logger:warning_msg("Not logged in, redirecting~n"),
            {redirect, [{controller, "security"}, {action,"login"}]};
	ParticipantId ->
	    Participant = boss_db:find(ParticipantId),
	    error_logger:info_msg("SessionID: ~p~nParticipant: ~p~n", [SessionID, Participant]),
	    {ok, Participant}
    end.
classroom_member(SessionID,ClassroomId) ->
   CurrentParticipantId = boss_session:get_session_data(SessionID, participant_id),
   Result = boss_db:find(participant_classroom_membership, [{participant_id,CurrentParticipantId},{classroom_id,ClassroomId}]),
   error_logger:info_msg("Result: ~p~n", [Result]),
   case Result of
        [] ->
	    error_logger:warning_msg("Not a member of classroom, redirecting~n"),
	    false;
        _ ->
	    true
    end.
