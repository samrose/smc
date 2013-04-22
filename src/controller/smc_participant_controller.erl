-module(smc_participant_controller, [Req, SessionID]).
-compile(export_all).
 
before_(_) ->
  security_lib:logged_in(SessionID).
