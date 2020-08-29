%-----------------question 1 a------------------------------
%sum the number in list
sum([],0).%if the number is an empty list - this size is 0
sum([X|Xs],N):-
	sum(Xs,N1),%recursive call for the rest of the list with new parameter(else                              there will be an ERROR
	N is N1+X.%summnig the numbers

%result
%2 ?- sum([1,2,3,54,7,8,3],X).
%X = 78.

%--------------question 1 b--------------------------------
%summing the digits of number
sumDigits(0,0).
sumDigits(X,SUM):-
	X1 is X//10,%to remove the rightest bit
	MOD is mod(X,10),%X%10
	sumDigits(X1,SUM1),%calling for new recursion
	SUM is SUM1+MOD.%adding to X1 the sum of current digi
%result:
%4 ?- sumDigits(12345,X).
%X = 15

%------------------question 2 a-----------------------------
%gets a number and devide it to the list of its digits
listNum(X,[X]):-
	X<10.
listNum(Num,List):-
	Num1 is Num//10,
	Mod is mod(Num,10),%Mod = the current digit
	listNum(Num1,Tail),
	append(Tail,[Mod],List).%adding

%1 ?- listNum(1234567,X).
%X = [1, 2, 3, 4, 5, 6, 7]

%------------------question 2 b-----------------------------
list_of_digits(0,[]).

list_of_digits(X,[D|Ds]):-
    X>0,%if x is positive
    D is X mod 10,%the current digit
    X1 is X //10,%to remove the LSB
    list_of_digits(X1,Ds).%recursive call with the divided                             numer and the rest of the list
%we will get the digits in reverse
list_of_digits(0,[0]).

list_of_digits(X,L1):-%shell function
    X>0,
    list_of_digits(X,L),%will go to the function above
    reverse(L,L1).%reverse for getting the propor list

%list_of_digits(12345,L).
%L = [5, 4, 3, 2, 1]


%--------------question 3 a---------------------------------
%gets 2 list and returns the intersection between them
interSection(L,[],[]):-!.
interSection([],L,[]):-!.

interSection([X|Xs],L,[X|M]):-
	member(X,L),!,
	interSection(Xs,L,M).

interSection([X|Xs], L, M):-
	not(member(X,L),
	 interSection(Xs,L,M).


%---------------question 3 b--------------------------------
% gets 2 list and returns the difference between them - only what is in
% L1.
minus([],_,[]).%if this is an empty list
minus([X|Rest],L2,[X|Z]):-
	intersection([X],L2,[]),
	minus(Rest,L2,Z).
minus([X|Rest],L2,Z):-
	member(X,L2),
	minus(Rest,L2,Z).

%- minus([1,2,3,4,7,8,0],[4,5,6],Z).
%Z = [1, 2, 3, 7, 8, 0]

%---------------question 4 a--------------------------------
%gets a list and return all the sublist
subSet([],[]).
subSet([X|Ys],[X|Xs]:-
       subSet(Ys,Xs).
subSet(Ys,[X|Xs]):-
	subSet(Ys,Xs).

%-----------question 4 b--------------------------------------------
subsetSum(L,N,L1):-
	subSet(L1,X), sum(L1,N).

