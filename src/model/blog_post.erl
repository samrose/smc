-module(blog_post, [Id, ClassroomId, ParticipantId, Title, Body]).
-compile(export_all).

-belongs_to(participant).
-belongs_to(classroom).
