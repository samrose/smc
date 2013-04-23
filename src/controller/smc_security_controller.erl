-module(smc_security_controller, [Req, SessionID]).
-compile([export_all]).

login('GET', []) ->
    ok;
login('POST', []) ->
    Email = Req:post_param("email"),
    PasswordHash = mochihex:to_hex( crypto:sha512(Req:post_param("password") ++ Email)),

    case boss_db:find(participant, [{email, Email}, {password_hash, PasswordHash}]) of
	[Participant] ->
	    boss_session:set_session_data(SessionID, participant_id, Participant:id()),
	    {redirect, [{controller, "profile"}, {action, "show"}, {id, Participant:id()}]};
	[] ->
	    error_logger:info_msg("Participant ~p unknown~n", [Email]),
	    {redirect, [{action, "login"}]}
    end.

logout('GET', []) ->
    boss_session:delete_session(SessionID),
    {redirect, [{action, "login"}]}.
