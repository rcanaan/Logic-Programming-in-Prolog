%-----------Rinat Canaan 207744012----------------------------
%----------------ex4----------------------------------------
%
%---------------q1-----------------------------------------
%gets 3 numbers and allocate the smallest, mid and max
%-------------a - without cuts!------------
min_max(X,Y,Z,MIN,MID,MAX):- X>=Y,Y>=Z,MAX is X,MID is Y,MIN is Z.
min_max(X,Y,Z,MIN,MID,MAX):- X>=Z,Z>=Y,MAX is X,MID is Z,MIN is Y.
min_max(X,Y,Z,MIN,MID,MAX):- Y>=Z,Z>=X,MAX is Y,MID is Z,MIN is X.
min_max(X,Y,Z,MIN,MID,MAX):- Y>=X,X>=Z,MAX is Y,MID is X,MIN is Z.
min_max(X,Y,Z,MIN,MID,MAX):- Z>=X,X>=Y,MAX is Z,MID is X,MIN is Y.
min_max(X,Y,Z,MIN,MID,MAX):- Z>=Y,Y>=X,MAX is Z,MID is Y,MIN is X.

/*
Output:
?- min_max(3,4,5,MIN,MID,MAX).
   MIN = 3,
   MID = 4,
   MAX = 5.
*/

% Question 1, green cuts
min_max1(X,Y,Z,MIN,MID,MAX):- X>=Y,Y>=Z,MAX is X,MID is Y,MIN is Z,!.
min_max1(X,Y,Z,MIN,MID,MAX):- X>=Z,Z>=Y,MAX is X,MID is Z,MIN is Y,!.
min_max1(X,Y,Z,MIN,MID,MAX):- Y>=Z,Z>=X,MAX is Y,MID is Z,MIN is X,!.
min_max1(X,Y,Z,MIN,MID,MAX):- Y>=X,X>=Z,MAX is Y,MID is X,MIN is Z,!.
min_max1(X,Y,Z,MIN,MID,MAX):- Z>=X,X>=Y,MAX is Z,MID is X,MIN is Y,!.
min_max1(X,Y,Z,MIN,MID,MAX):- Z>=Y,Y>=X,MAX is Z,MID is Y,MIN is X.
/*
Output:
?- min_max(3,4,5,MIN,MID,MAX).
   MIN = 3,
   MID = 4,
   MAX = 5.
*/

% Question 1, red cuts
min_max2(X,Y,Z,MIN,MID,MAX):- X>=Y,Y>=Z,MAX is X,MID is Y,MIN is Z,!.
min_max2(X,Y,Z,MIN,MID,MAX):- X>=Z,Z>=Y,MAX is X,MID is Z,MIN is Y,!.
min_max2(X,Y,Z,MIN,MID,MAX):- Y>=Z,Z>=X,MAX is Y,MID is Z,MIN is X,!.
min_max2(X,Y,Z,MIN,MID,MAX):- Y>=X,X>=Z,MAX is Y,MID is X,MIN is Z,!.
min_max2(X,Y,Z,MIN,MID,MAX):- Z>=X,X>=Y,MAX is Z,MID is X,MIN is Y,!.
min_max2(X,Y,Z,MIN,MID,MAX):- MAX is Z,MID is Y,MIN is X. % we didn't check if Z>=Y,Y>=X, are true- that is why it't red.
/*
Output:
?- min_max1(3,4,5,MIN, MID, MAX).
   MIN = 3,
   MID = 4,
   MAX = 5
*/







%------------------q2--------------------------------------
%we will say what is the kind of evert cut!
%
%buy(X,Y):-!(1) , car(Y),!(2) ,price(Y,Z),!(3) , Z<1000, !(4) .
%car(alpha):-!(5) .
%car(subaru):-!(6) .
%price(alpha,1100):-!(7) .
%price(subaru,990):-!(8) .
%
%(1) - "extra green" - because he has no more place to backtrack
% (2)- "harm red" - it finds that the first car is "alpha" and its
% price is 1100, and we can't chnage it anymore. it will try to
% backtrack and will return "false"
% (3) - "harm red" - the same as (2).
% (4) - "usefull green" - after we found the "subaro" it will prevent to
% look for more results.
% (5) - "harm red" - because it stays with "alpha"
% (6) - "extra green"-  as long there are no more cars of course
% (7) - "extra green" - has no influence, because as long we chose
% "alpha" anyway it won't get into any other condition
% (8) - "extra green"

%----------------q3----------------------------------------
%definds intersecion of 2 lists, and also declares "no" if t%they don't have any common items

intersection([],_,[]).
intersection([H|T],L,[H|M]):-
	member(H,L),!,intersection(T,L,M).
intersection([H|T],L,M):-
	not(member(H,L)), intersection(T,L,M).

inter(L1,L2,R):-
	intersection(L1,L2,L3),
	(L3 =[]->R=no; R=L3).

%output:
% ?- inter([b,c,d],[a,b,c,r],R).
%R = [b, c]
%
%?- inter([b,c,d],[a,r],R).
%R = no.
---------------q4-------------------------------------------
%gets a list L and return hown many times each color appears
%ve any cousing here in recursive tail with 3 accumulators
rgb_sort(L,[R,G,B]):-
	rgb_sort(L,0,0,0,R,G,B).%cals a help func with the initial accu,ulators with right now are 0

rgb_sort([],R,G,B,R,G,B).%the stop point  -empty list

%if the lists are not empty:
%
%%if the first item is red
rgb_sort([red|L],AccR ,AccG ,AccB ,R ,G ,B):-
	AccR1 is AccR +1,%new accumulator for the red
	rgb_sort(L ,AccR1 ,AccG ,AccB ,R ,G , B).%calling to recursion with the rest of what i accumulate

%if the first is green:
rgb_sort([green|L],AccR ,AccG ,AccB ,R ,G ,B):-
	AccG1 is AccG +1,%adding the first item to the accumulator of the green
	rgb_sort(L ,AccR ,AccG1 ,AccB ,R ,G , B).

%if the first is blue:
rgb_sort([blue|L],AccR ,AccG ,AccB ,R ,G ,B):-
	AccB1 is AccB +1,%adding the first to the accumulator
	rgb_sort(L ,AccR ,AccG ,AccB1 ,R ,G , B).

%output:
%   rgb_sort([red,green,blue,blue,blue,green,red],L).
%L = [2, 2, 3]


%--------------------------q5-----------------------------
% get a list incliding sublist and atoms and return only the items -
% without parentheses

%stop condition
flatten([],[]).

%if there X that is atom - cancatanate to re rest of the "flatten"
flatten([X|Tail],[X|L1]):-
         atomic(X), flatten(Tail,L1).

%----if X is list, we will do seperately flatten for it, for all the rest flatten and then append
flatten([X|Tail],L):-
          is_list(X), flatten(X,L2), flatten(Tail,L3),
          append(L2,L3,L).

%output:
% flatten([[1],2,[3,4]],X).
%X = [1, 2, 3, 4]
