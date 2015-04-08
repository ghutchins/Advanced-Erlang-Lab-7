
% CSC 231 Lab 7: Advanced Erlang: Higher Order Functions, Type Definitions
% Georgina Hutchins

-module(lab7).
-export([map/2,reduce/2,filter/2,getStringTree/0,stringToFloat/1,getExpression1/0,getExpression2/0,getExpression3/0, even/1, extractEvens/1, isA/1, beginsWithA/1, extractAWords/1, isTrue/2, logicalOR/1, greaterThan3/1, getLength/2, longStrings/1, findNode/2, findInTree/2, concatenate/2, strcat/1, evaluate/1, evaluateNode/1, findMax/2, max/1]).

-record(binaryTreeNode, {value,left=null,right=null}).
-record(binaryTree, {rootNode=null}).

getStringTree() -> 
#binaryTree{rootNode = #binaryTreeNode{value = "Erlang", left = #binaryTreeNode{value = "as", left = #binaryTreeNode{value = "a",left = null,right = null},right = #binaryTreeNode{value = "in",left = null,right = null}},right = #binaryTreeNode{value = "types",left = null, right = null}}}.

getExpression1() ->
#binaryTree{rootNode = #binaryTreeNode{value="2.0"}}.

getExpression2() ->
#binaryTree{rootNode = #binaryTreeNode{value="+",left=#binaryTreeNode{value="2.0"},right=#binaryTreeNode{value="4.0"}}}.

getExpression3() ->
#binaryTree{rootNode = #binaryTreeNode{value="/",left=#binaryTreeNode{value="+", left=#binaryTreeNode{value="3.0"},right=#binaryTreeNode{value="2.0"}},right=#binaryTreeNode{value="*",left=#binaryTreeNode{value="2.0"},right=#binaryTreeNode{value="2.5"}}}}.

stringToFloat(X) -> 
	element(1,string:to_float(X)).

map(_,[]) ->
	[];
map(F,[X|XS]) ->
	[F(X)|map(F,XS)].

reduce(_, [A]) ->
	A;
reduce(F, [A|AS]) ->
	F(A, reduce(F,AS)).

filter(_,[]) ->
	[];
filter(P,[X|XS]) ->
	case P(X) of 
	true ->
		 [X|filter(P,XS)];
	_ -> 
		filter(P,XS)
	end.

%%%

%problem 1a
even(L) ->
	L rem 2 == 0.
		
extractEvens(L) ->
	filter(fun even/1, L).


%problem 1b
isA(X) ->
	if
		X == $a -> true;
		X == $A -> true;

		true -> false
	end.

beginsWithA(String) -> 
	isA(hd(String)).
 			
extractAWords(StringList) ->
	filter(fun beginsWithA/1, StringList).


%problem 1c
isTrue(X,Y) ->
	X orelse Y.

logicalOR(BoolList) ->
	reduce(fun isTrue/2, BoolList).


%problem 1d
greaterThan3(String) ->
	Chop_ = getLength(String,3),
	if
		Chop_ == [] -> false;
		true -> true
	end.

getLength(Str,C) ->	
	if
		C == 0 -> Str;
		Str == [] -> [];
		true ->
			getLength(tl(Str),C-1)
	end.		

longStrings(SList) ->
	filter(fun greaterThan3/1, SList).
			

%problem 1e 
concatenate([X|XS],[Y|YS]) ->
	[X|XS] ++ [Y|YS].

strcat(List) ->
	reduce(fun concatenate/2, List).


%problem 1f
findMax(X,Y) ->
	if
		X > Y -> X;
		true -> Y
	end.

max(L) ->
	reduce(fun findMax/2, L).


%problem 2
findNode(_, null) -> false;
findNode(String,Node) ->
	if
		String == Node#binaryTreeNode.value -> true;
	true ->
		findNode(String,Node#binaryTreeNode.left) orelse
		findNode(String,Node#binaryTreeNode.right)
	end.

findInTree(StringLabel,Tree) ->
	findNode(StringLabel,Tree#binaryTree.rootNode).


%problem 3
evaluateNode(Node) ->
	if
		Node#binaryTreeNode.value == "+" -> 
			evaluateNode(Node#binaryTreeNode.left) +
			evaluateNode(Node#binaryTreeNode.right);
		Node#binaryTreeNode.value == "-" -> 
			evaluateNode(Node#binaryTreeNode.left) -
			evaluateNode(Node#binaryTreeNode.right);
		Node#binaryTreeNode.value == "*" -> 
			evaluateNode(Node#binaryTreeNode.left) *
			evaluateNode(Node#binaryTreeNode.right);
		Node#binaryTreeNode.value == "/" -> 
			evaluateNode(Node#binaryTreeNode.left) /
			evaluateNode(Node#binaryTreeNode.right);
	true ->
		stringToFloat(Node#binaryTreeNode.value)

	end.

evaluate(Tree) ->
	evaluateNode(Tree#binaryTree.rootNode).			
		

