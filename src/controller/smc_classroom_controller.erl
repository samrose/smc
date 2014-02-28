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

blog_post_index('GET', ["classroom_id",ClassroomId],Security) ->
    Classroom = boss_db:find(ClassroomId),
    BlogPosts = boss_db:find(blog_post, [{classroom_id, ClassroomId}]),
        {ok, [{blog_posts,BlogPosts},{classroom,Classroom}]}.

blog_post_show('GET', ["classroom_id",ClassroomId,"blog_post_id",BlogPostId], Security) ->
        BlogPost =  boss_db:find(BlogPostId),
        CurrentParticipantId = boss_session:get_session_data(SessionID,participant_id),
        error_logger:info_msg("ParticipantID: ~p~n", [CurrentParticipantId]),
        case security_lib:classroom_member(SessionID,ClassroomId) of
            false ->
                error_logger:info_msg("Participant is not a member of this classroom"),
                        boss_flash:add(SessionID, notice, "Sorry!", "Your are not a member of that classroom ..."),
                {redirect, "/profile/show/"++CurrentParticipantId};
            true ->
                error_logger:info_msg("Blog Post Controller: show classroom:~p~n", [BlogPost]),
                %%{json, [{success, true}, {message, ''}, {doc, [{agent, Participant}, {classroom, ClassroomId}]}]}.
                {ok, [{blog_post, BlogPost}]}
        end.
blog_post_create('GET', [], Security) ->
  ok;
blog_post_create('POST', [classroom_id,ClassroomId], Security) ->
  Now = erlang:now(),
  Title = Req:post_param("title"),
  Body = Req:post_param("body"),
  ParticipantId = boss_session:get_session_data(SessionID,participant_id),
  CreatedOn = Now,
  ModifiedOn = Now,
  Post = blog_post:new(id,ClassroomId,ParticipantId, Title, Body, erlang:now(),erlang:now()),
  case Post:save() of
    {ok, SavedPost} ->
        {redirect,"/classroom/blog_post_show/classroom_id/{{classroom.id}}/blog_post_id/" ++ SavedPost:id()};
    {error, Reason} ->
        Reason
  end.
