-module(smc_classroom_controller, [Req, SessionID]).
-compile([export_all]).

before_(_) ->
        security_lib:logged_in(SessionID).

show('GET', [ClassroomId, ParticipantId], Security) ->
    Classroom = boss_db:find(ClassroomId),
    Participant = boss_db:find(ParticipantId),
    error_logger:info_msg("Classroom Controller: show classroom: ~p~nshow participant: ~p~n", [Classroom,Participant]),
    %%{json, [{success, true}, {message, ''}, {doc, [{agent, Participant}, {classroom, Classroom}]}]}.
    {ok, [{participant, Participant},{classroom, Classroom}]}.
index('GET', ["participant-" ++ _ = ParticipantId]) ->
    Participant = boss_db:find(ParticipantId),
    Classrooms = boss_db:find(participant_classroom_membership, [{participant_id, ParticipantId}]),
    ClassroomsAndNames = [[{id, (X:classroom()):id()},{name, binary_to_list((X:classroom()):name())},{description, binary_to_list((X:classroom()):description())}, {image, (X:classroom()):image()}] || X <- Classrooms],
    %%{json, [{success, true}, {message, ''}, {doc, [{classrooms, ClassroomsAndNames}]}]};
    {ok, [{classrooms, ClassroomsAndNames}]}.
