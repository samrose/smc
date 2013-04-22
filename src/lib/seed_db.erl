-module(seed_db).
-compile(export_all).


exec_all() ->
  participants().


participants() ->
     Participant = participant:new(id, "First", "Last", "email@example.com", mochihex:to_hex(crypto:sha512("test" ++ "email@example.com"))),
     Participant:save().
