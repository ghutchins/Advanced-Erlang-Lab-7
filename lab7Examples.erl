-module(lab7Examples).
-export([map/2,reduce/2,filter/2,square/1,squareList/1,add/2,sumList/1,greaterThan10/1,dropSmall/1, sumTree/1, sumNode/1,getNumberTree/0]).

map(_,[]) ->
	[];
map(F,[X|XS]) ->
	[F(X)|map(F,XS)].

square(X) -> 
	X*X.

squareList(L) ->
	map(fun square/1, L).


reduce(_, [A]) ->
	A;
reduce(F, [A|AS]) ->
	F(A, reduce(F,AS)).

add(X,Y) ->
	X + Y.
sumList(L) -> 
	reduce(fun add/2, L).

filter(_,[]) ->
	[];
filter(P,[X|XS]) ->
	case P(X) of 
	true ->
		 [X|filter(P,XS)];
	_ -> 
		filter(P,XS)
	end.

greaterThan10(X) ->
	X > 10.
dropSmall(L) ->
	filter(fun greaterThan10/1, L).

-record(binaryTreeNode, {value,left=null,right=null}).
-record(binaryTree, {rootNode=null}).

getNumberTree() -> 
#binaryTree{rootNode = #binaryTreeNode{value = 7, left = #binaryTreeNode{value = 5, left = #binaryTreeNode{value = 3},right = #binaryTreeNode{value = 8}},right = #binaryTreeNode{value = 12}}}.

sumNode(null) -> 0;
sumNode(N) -> N#binaryTreeNode.value + sumNode(N#binaryTreeNode.left) + sumNode(N#binaryTreeNode.right).

sumTree(T) -> sumNode(T#binaryTree.rootNode).


	




