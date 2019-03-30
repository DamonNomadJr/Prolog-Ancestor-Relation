% Sample rules
% parent(john, paul).
% parent(john, mary).

% parent(paul, henry).
% parent(paul, june).

% parent(henry, helen).
% parent(henry, josh).

% parent(mary, adam).

% Ancestor Structure Logic, X is ancestor of Y where X is a direct parent of Y or related by other parents A.
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, A), ancestor(A, Y).

% Common Ancestor Logic Where X is the same ancestor for Y and Z
common_ancestor(X, Y, Z) :- ancestor(X, Y), ancestor(X, Z).

% Cloeset Common Ancestor Structor Logic where we find that if the X is the very immediate 
% ancestor of Y and Z if there are not parents that are common with Y and Z other than X
closest_common_ancestor(X, Y ,Z) :- parent(X, Y), parent(X, Z).
closest_common_ancestor(X, Y, Z) :- common_ancestor(X, Y, Z), \+(ccafunc(X, Y, Z)).

    % A rule to define if we have another parent other than X for Y and Z
    ccafunc(X, Y, Z) :- ancestor(X, B), common_ancestor(B, Y, Z).

closest_ancestor(X, Y) :- parent(X, Y), ancestor(X, Y).

% Ancestor List logic statements where if X is an ancestor of Y we return all the inbetween ancestors.
ancestorList(X, Y, []) :- parent(X, Y).
ancestorList(X, Y, L) :- ancestor(X, Y), parent(X, Z), ancestor(Z, Y), append([Z], L2, L), ancestorList(Z, Y, L2).

% I have two different descendantTree Logic statements however both fail to completely return the 
% true valid descendantTree for all the family members.
descendantTree(X, [X]) :- \+parent(X, Y), ancestor(Z, X).
descendantTree(X, L) :- findall(C, parent(X, C), ResultList), closest_ancestor(X, C), addToList([X], ResultList, L).
descendantTree(X, L) :- forall(parent(X, C), ( gpc(C, L1) , addToList([], L1, L) ) ).

descendantTree2(X, L) :- findall(C, parent(X, C), R), parent(C, G), addToList([X], R, L).
descendantTree2(X, L) :- findall(C, parent(X, C), R), addToList([X], L2, L), descendantTree(C, L2).

findAllChildern(X, Y) :- parent(X, Y).

numberofchildren(Person, N) :- parent(Person, _), N is N+1.

% Appending an item to the list
append([], List, List).
append([H|T], List,[H|R]) :- append(T, List, R).

% Combining two lists
addToList([], List, [List]).
addToList([H|T], List, [H|R]) :- addToList(T, List, R).
