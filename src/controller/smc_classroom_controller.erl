-module(smc_classroom_controller, [Req, SessionID]).
-compile([export_all]).

before_(_) ->
        security_lib:logged_in(SessionID).
show('GET', [ClassroomId], Security) ->
	case security_lib:classroom_member(SessionID,ClassroomId) of
	    false ->
    	        error_logger:info_msg("You are not member of classroom"),
                {redirect, [{controller, "smc_profile"},{action,"show"}]};
	    true ->  
                Classroom = boss_db:find(ClassroomId),
    	        error_logger:info_msg("Classroom Controller: show classroom:~p~n", [Classroom]),
	        %%{json, [{success, true}, {message, ''}, {doc, [{agent, Participant}, {classroom, Classroom}]}]}.
    	        {ok, [{classroom, Classroom}]}
        end.
index('GET', ["participant-" ++ _ = ParticipantId], Security) ->
    Participant = boss_db:find(ParticipantId),
    Classrooms = boss_db:find(participant_classroom_membership, [{participant_id, ParticipantId}]),
    ClassroomsAndNames = [[{id, (X:classroom()):id()},{name, binary_to_list((X:classroom()):name())},{description, binary_to_list((X:classroom()):description())}, {image, (X:classroom()):image()}] || X <- Classrooms],
    %%{json, [{success, true}, {message, ''}, {doc, [{classrooms, ClassroomsAndNames}]}]};
    {ok, [{classrooms, ClassroomsAndNames}]}.
