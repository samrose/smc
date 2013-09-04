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

show('GET', []) ->
    {ok, []}.
