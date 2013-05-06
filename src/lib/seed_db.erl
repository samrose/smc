-module(seed_db).

-export([exec_all/0]).


exec_all() ->
  classrooms(),
  participants().

classrooms()->
%% p("Creating Classrooms"),
 case boss_db:find(classroom, [{name, "Virtual Communities"}]) of
   [Group1] ->
     ok;
   [] ->	
     [(classroom:new(id, Name,Description,Image)):save() || Name <- ["Virtual Communities","Cooperation and Collaboration","NetSmart:How to thrive online"], Description <- ["Lorem ipsum dolor sit amet, consectetur adipiscing elit","Lorem ipsum dolor sit amet, consectetur adipiscing elit","Lorem ipsum dolor sit amet, consectetur adipiscing elit"], Image <- [{},{},{}]]
 end.

participants() ->
     Participant = participant:new(id, "First", "Last", "email@example.com", mochihex:to_hex(crypto:sha512("test" ++ "email@example.com"))),
     Participant:save().


