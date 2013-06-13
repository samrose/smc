-module(participant_roles, [Id, ParticipantId, RoleId]).
-compile([export_all]).

-belongs_to(participant).
-belongs_to(role).
