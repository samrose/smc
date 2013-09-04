-module(seed_db).

-export([exec_all/0]).


exec_all() ->
  classrooms(),
  participants(),
  roles().
 % blog_posts().
p(Arg) ->
      io:format("Creating ~s...~n", [Arg]).

classrooms()->
  p("Creating Classrooms"),
	case boss_db:find(classroom, [{name, "Virtual Communities"}]) of
   [Classroom1] ->
     ok;
   [] ->	
     [(classroom:new(id, Name,Description,Image)):save() || Name <- ["Virtual Communities","Cooperation and Collaboration","NetSmart:How to thrive online"], Description <- ["Lorem ipsum dolor sit amet, consectetur adipiscing elit","Lorem ipsum dolor sit amet, consectetur adipiscing elit","Lorem ipsum dolor sit amet, consectetur adipiscing elit"], Image <- [{},{},{}]]
 end.

participants() ->
  p("Creating Students and joining Classrooms"),
	Classroom1Id = (boss_db:find_first(classroom, [{name, "Virtual Communities"}])):id(),
	Classroom2Id = (boss_db:find_first(classroom, [{name, "Cooperation and Collaboration"}])):id(),
	Classroom3Id = (boss_db:find_first(classroom, [{name, "NetSmart:How to thrive online"}])):id(),
  NewParticipant = participant:new(id, "Jane", "Student", "email@example.com", mochihex:to_hex(crypto:sha512("test" ++ "email@example.com"))),
  case  NewParticipant:save() of
    {ok, SavedParticipant} ->
      ParticipantId = SavedParticipant:id(),
      (participant_classroom_membership:new(id, ParticipantId, Classroom1Id)):save(),
      (participant_classroom_membership:new(id, ParticipantId, Classroom2Id)):save(),
      (participant_classroom_membership:new(id, ParticipantId, Classroom3Id)):save();
    {error, Reason} ->
      Reason
  end.
roles()->
    p("Creating Default Roles"),
    [(role:new(id, Role)):save() || Role <- ["Admin, Teacher, Student"]].      
  
%blog_posts()->
%	p("Creating blog posts"),
%	  ParticipantId = boss_db:find(participant,[{email,"email@example.com"}]),
%	  BlogClassroom1Id = (boss_db:find_first(classroom, [{name, "Virtual Communities"}])):id(),
%	  BlogClassroom2Id = (boss_db:find_first(classroom, [{name, "Cooperation and Collaboration"}])):id(),
%	  BlogClassroom3Id = (boss_db:find_first(classroom, [{name, "NetSmart:How to thrive online"}])):id(),
%	  BlogPost1 = boss_db:find(blog_post, [{title, "Title One"}]),
%	case BlogPost1 of
%		[BlogPost1] ->
%			ok;
%		[] ->
%	[(blog_post:new(id,ClassroomId,ParticipantId,Title,Body)):save() || ClassroomId <- [BlogClassroom1Id,BlogClassroom2Id,BlogClassroom3Id], Title <- ["Title One","Title Two","Title Three"], Body <- ["Lorem ipsum dolor sit amet, consectetur adipiscing elit","Lorem ipsum dolor sit amet, consectetur adipiscing elit","Lorem ipsum dolor sit amet, consectetur adipiscing elit"]]
%	end.	

