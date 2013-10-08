-module(blog_post_comment,[Id, BlogPostId, ParticipantId, Title, Body, CreatedOn, ModifiedOn]).
-compile(export_all).

-belongs_to(participant).
-belongs_to(blog_post).

