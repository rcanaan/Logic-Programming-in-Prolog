%-------------Rinat Canaan 207744012------------------------
%------------------------EX 5------------------------------
%--------------------question 1--------------------------
%gets a list and return the first item and the last one
%if the list contains 1 item - don't check for more
first_last([X],X,X):-!.
%---else- if there are more items - recursivly call for the rest.
first_last([X|L],X,Y):-
	first_last(L,_,Y).

/*
output:
first_last([1,2,3,4,5,6],X,Y).
X = 1,
Y = 6.

	*/

/*
-------------------quesion  2------------------------------
returns all the product of items from  1 list.
---------------a-- regular recursion------------------
*/
%if the number is an empty list - this size is 0
product([X],X).
product([X|Xs],P):-
	product(Xs,P1), P is P1*X.
/*
 product([1,2,3,4],P).
P = 24	*/

%----------b--------tail recursion-----------------------
%if L is an empty list return what we have accumulate so far. green cut!
tail_product([],X,X):-!.

tail_product(L,X):-%the main calling func
	tail_product(L,1,X).%shell function. at the start the Acc will be 1


tail_product([H|T],Acc,P):-%if the list has items
	Acc1 is Acc*H,%creating new accumulator - for advancing
	tail_product(T,Acc1,P).%calling recursivly for the rest of the list with the new Acc1

/*tail_product([1,2,3,4,6,8,34],P).
P = 39168*/

%----------c----deep recursion for deep list-------------
deepProduct([X],X).

/*/if X is list- divide for X and Xs(the rest) and call recursivly for each part and multiply the results*/
deepProduct([X|Xs],R):-
	is_list(X),deepProduct(X,R1),deepProduct(Xs,R2),R is R1*R2.
%if X is number
deepProduct([X|Xs],R):-
	number(X),deepProduct(Xs,R2), R is R2*X.
%if X is not list/number, call the recursion and return what we got
deepProduct([X|Xs],R):-
	atom(X),deepProduct(Xs,R).
/*deepProduct([1,2,[4,5,6],3],P).
P = 720
	*/


%----------------question 3 version 1-----------------------------------
%gets 2 list, and return every item in the second list multiply 2
%--------------------------tail----------------
reverse([],Acc,Acc).
reverse([X|Xs],Acc,Res):-
	reverse(Xs,[X|Acc],Res).

my_reverse(L,Res):-reverse(L,[],Res).


%green cut
kuku([X],[L]):-Y is 2*X,append([X],[Y],L),!.
kuku([H|T],[X|L]):-Y is H*2,append([H],[Y],X),kuku(T,L),!.
kukuT(L1,L2):-kuku(L1,L),reverse(L,L2).

%5 ?- kukuT([1,2],X).
%X = [[2, 4], [1, 2]] .

%7 ?- kukuT([1,2,3,4],X).
%X = [[4, 8], [3, 6], [2, 4], [1, 2]]

%----------------------3--------Regular------------------
%green cut
kuku1([X],[L]):-Y is 2*X,append([X],[Y],L),!.
kuku1([H|T],L):-kuku1([H],L1),kuku1(T,L2),append(L1,L2,L),!.
kukuR(L1,L2):-kuku1(L1,L),reverse(L,L2).

%1 ?- kukuR([1,2,3,4],X).
%X = [[4, 8], [3, 6], [2, 4], [1, 2]].

%2 ?- kukuR([1,2],X).
%X = [[2, 4],

%-------------------3------------deep----------------------
%red cut
kuku2([X],[L]):-number(X),Y is 2*X,append([X],[Y],L),!.
kuku2([X],[L]):-kuku2(X,L),!.
kuku2([H|T],L):-kuku2([H],L1),kuku2(T,L2),append(L1,L2,L),!.
%kuku2([H|T],L):-kuku2([H],L1),kuku2(T,L2),append(L1,L2,L).
kukuD(L1,L2):-kuku2(L1,L),reverse(L,L2).

%4 ?- kukuD([1,[2]],X).
%X = [[[2, 4]], [1, 2]].

%6 ?- kukuD([[1,2],[2,3],1],X).
%X = [[1, 2], [[2, 4], [3, 6]], [[1, 2], [2, 4]]].

%------------------question 3 version 2-----------------
%----regular-----
kuku([],[])% if the list is empty- returns empty list

%for more items - will cancatenate the pair (h,h2) to T
kuku([H|T],R):-
	H2 is H*2
	kuku(T,T1),
	append(T1,[[H,H2]],R).%append (h,h2) at the end and this will do the reverse action

%-------tail recursion--------
%shell func
kukuTail(L,R):-
	kukuTail(L,[],R).%calling with []- for accumulator. empty at the start.

kukuTail([],Acc,Acc).%if he gets an empty list and has an Acc - return the acc
kukuTail([H|T],Acc,R):-
	H2 is H*2
	kukuTail(T,[[H,H2]|Acc],R).%here it will be reversed automaticly.because we cancat before the recursion - (h,h2) will be at the end. the old result will be pushed to the bottom and the new ones to the start

%--------deep---------
kukuDeep([],[])% if the list is empty- returns empty list
kukuDeep1(L,R):-
	kukuDeep(L,L1),reverse(L1,R).
%for more items - will cancatenate the pair (h,h2) to T
kukuDeep([H|T],[[H,H2]|T1]):-
	number(H),!,H2 is H*2
	kuku(T,T1),


kukuDeep([H|T],[H1|T1]):-
	is_list(H),kukuDeep1(H,H1),kukuDeep(T,T1).

%-----------------question 4-----------------------------
%flatten a list with tail recursion
%
my_flatten(L,R):-
	my_flatten(L,[],R).%a shell func with some accumulator

%the shell func:
%
%if L is an empty list return what we have accumulate so far
my_flatten([],Acc,Acc1):-
	reverse(Acc,Acc1).%because at the bottom we will afdd it reversly so we need to revrse it 1 more time

%if L is not an empty list
%the ! is a green cut because we added the "atomic(X)"
my_flatten([X|Xs],Acc,R):-
	is_list(X),!, append(X, Xs, Y), my_flatten(Y,Acc,R).

my_flatten([X|Xs], Acc, R):-
	    atomic(X), my_flatten(Xs, [X|Acc], R).%adding X to the rest of the items, but recursivly

%output:
% ?- my_flatten([a,2,[3]],X).
%X = [a, 2, 3].



/*
---------------question 5---------------------------------
gets list and reverse its items
*/
deepReverse([],Acc,Acc).
deepReverse([X|Xs],Acc,Res):-
	is_list(X),
	deepReverse(X,[],Res1),
	deepReverse(Xs,[Res1|Acc],Res),!.
deepReverse([X|Xs],Acc,Res):-
	deepReverse(Xs,[X|Acc],Res).
deep_my_reverse(L,Res):-
	deepReverse(L,[],Res).
