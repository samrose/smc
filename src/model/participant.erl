-module (participant, [Id, FirstName, LastName, Email, PasswordHash]).
-compile(export_all).

%%Many to many relationships
-has({participant_classroom_memberships, many}).
-has({participant_roles, many}).
