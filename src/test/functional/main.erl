-module(main).
-export([start/0]).

start() ->
    boss_web_test:get_request("/login", [], 
        [ % We are checking for some basic information here, loading ok, presence of links and form elements
            fun(Res) ->
		     boss_assert:http_ok(Res) end,
            fun(Res) ->
	    	     boss_assert:tag_with_text("label", "Email:", Res) end,
            fun(Res) ->
	     	     boss_assert:tag_with_text("label", "Password:", Res) end,
            fun(Res) ->
	     	     boss_assert:tag_with_text("title", "SocialMediaClassroom", Res) end
        ],
	[ "*** Logging in ***",
	  fun(Response1) ->
		  boss_web_test:submit_form("login_form",
					    [{"Email:", "email@example.com"},{"Password:", "test"}],
					    Response1,
					    [
					     fun(Response1) -> boss_assert:http_redirect(Response1) end,
					     fun(Response1) ->
						     %% Getting the first (and currently only agent) to verify URL
						     Id = (boss_db:find_first(agent, [])):id(),
						     boss_assert:location_header("/profile/show/" ++ Id, Response1)
					     end
					    ],
					    [
					     "*** On the profile page now ***",
					     fun(Response2) ->
						     boss_web_test:follow_redirect(Response2,
										   [
										    fun(Response2) ->
											    boss_assert:http_ok(Response2)
										    end,
										    fun(Response2) ->
   											    boss_assert:link_with_text("Group 3", Response2)
										    end,
										    fun(Response2) ->
											    boss_assert:link_with_text("Group 5", Response2)
										    end
										   ],
										   [])
					     end
					    ])
	  end
	]).
