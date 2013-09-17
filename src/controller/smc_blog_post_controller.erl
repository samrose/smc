-module(smc_blog_post_controller, [Req, SessionID]).
-compile(export_all).

before_(_) ->
        security_lib:logged_in(SessionID).
index('GET', [ClassroomId],Security) ->
	BlogPosts = boss_db:find(blog_post, [{classroom_id, ClassroomId}]),
	{ok, [{blog_posts,BlogPosts}]}.

%create('GET', []) ->
 %ok;

%create('POST', []) ->
% GreetingText = Req:post_param("greeting_text"),
% NewGreeting = greeting:new(id, GreetingText),
% {ok, SavedGreeting} = NewGreeting:save(),
% {redirect, [{action, "list"}]}.

show('GET', [BlogPostId], Security) ->
        BlogPost =  boss_db:find(BlogPostId),
        Classroom = BlogPost:classroom_id(),
        CurrentParticipantId = boss_session:get_session_data(SessionID,participant_id),
        error_logger:info_msg("ParticipantID: ~p~n", [CurrentParticipantId]),
        case security_lib:classroom_member(SessionID,Classroom) of
            false ->
                error_logger:info_msg("Participant is not a member of this classroom"),
                        boss_flash:add(SessionID, notice, "Sorry!", "Your are not a member of that classroom ..."),
                {redirect, "/profile/show/"++CurrentParticipantId};
            true ->
                error_logger:info_msg("Blog Post Controller: show classroom:~p~n", [BlogPost]),
                %%{json, [{success, true}, {message, ''}, {doc, [{agent, Participant}, {classroom, Classroom}]}]}.
                {ok, [{blog_post, BlogPost}]}
        end.
