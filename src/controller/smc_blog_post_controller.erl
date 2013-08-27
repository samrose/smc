-module(smc_blog_post_controller, [Req, SessionID]).
-compile(export_all).


create('GET', []) ->
    %% Create; renders create page                                                                                                                                                                          
    {ok, []};

show('GET', []) ->
    {ok, []};
