-module(smc_profile_controller, [Req, SessionID]).
-compile([export_all]).


before_(_) ->
    security_lib:logged_in(SessionID).

index('GET', [Id], Authorized ) ->
    Participant = boss_db:find(Id),
    Classrooms = Participant:participant_classroom_memberships(),
    {ok, [{participant, Participant}, {classrooms, Classrooms}]}.
