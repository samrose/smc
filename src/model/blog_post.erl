-module(blog_post, [Id, ClassroomId, ParticipantId, Title, Body, CreatedOn, ModifiedOn]).
-compile(export_all).

-belongs_to(participant).
-belongs_to(classroom).
