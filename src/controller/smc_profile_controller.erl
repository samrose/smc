-module(smc_profile_controller, [Req, SessionID]).
-compile([export_all]).


before_(_) ->
    security_lib:logged_in(SessionID).

my_smc('GET', Authorized ) ->
    CurrentParticipantId = boss_session:get_session_data(SessionID,participant_id),
    {redirect, "/profile/index/"++CurrentParticipantId}.

index('GET', [Id], Authorized ) ->
    Participant = boss_db:find(Id),
    Classrooms = Participant:participant_classroom_memberships(),
    {ok, [{participant, Participant}, {classrooms, Classrooms}]}.
