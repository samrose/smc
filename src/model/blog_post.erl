-module(blog_post, [Id, ClassroomId, ParticipantId, Title, Body, CreatedOn, ModifiedOn]).
-compile(export_all).

-has({blog_post_comments, many}).
-belongs_to(participant).
-belongs_to(classroom).
