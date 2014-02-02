-module(smc_classroom_controller, [Req, SessionID]).
-compile([export_all]).

before_(_) ->
    security_lib:logged_in(SessionID).

show('GET', [ClassroomId], Authorized) ->
    CurrentParticipantId = boss_session:get_session_data(SessionID,participant_id),
    error_logger:info_msg("ParticipantID: ~p~n", [CurrentParticipantId]),
    case security_lib:classroom_member(SessionID,ClassroomId) of
	false ->
	    error_logger:info_msg("Participant is not a member of this classroom"),
	    boss_flash:add(SessionID, notice, "Sorry!", "Your are not a member of that classroom ..."),
	    {redirect, "/profile/show/"++CurrentParticipantId};
	true ->  
	    Classroom = boss_db:find(ClassroomId),
	    error_logger:info_msg("Classroom Controller: show classroom:~p~n", [Classroom]),
	    BlogPosts = Classroom:blog_posts(),
	    %%{json, [{success, true}, {message, ''}, {doc, [{agent, Participant}, {classroom, Classroom}]}]}.
	    {ok, [{classroom, Classroom},{blog_posts, BlogPosts}]}
    end.

index('GET', ["participant-" ++ _ = ParticipantId], Authorized) ->
    Participant = boss_db:find(ParticipantId),
    Classrooms = boss_db:find(participant_classroom_membership, [{participant_id, ParticipantId}]),
    ClassroomsAndNames = [[{id, (X:classroom()):id()},{name, binary_to_list((X:classroom()):name())},{description, binary_to_list((X:classroom()):description())}, {image, (X:classroom()):image()}] || X <- Classrooms],
    %%{json, [{success, true}, {message, ''}, {doc, [{classrooms, ClassroomsAndNames}]}]};
    {ok, [{classrooms, ClassroomsAndNames}]}.
