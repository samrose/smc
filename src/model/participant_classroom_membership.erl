-module(participant_classroom_membership, [Id, ParticipantId, ClassroomId]).
-compile([export_all]).

-belongs_to(participant).
-belongs_to(classroom).
