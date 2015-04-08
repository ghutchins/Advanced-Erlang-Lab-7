-module(lab7Tester).
-export([test1a/0,test1b/0,test1c/0,test1d/0,test1e/0,test1f/0,test2/0,test3/0]).

-record(binaryTreeNode, {value,left=null,right=null}).
-record(binaryTree, {rootNode=null}).

test1a() ->
	io:write(lab7:extractEvens([])), 
	io:format("\n"), 
	io:write(lab7:extractEvens([2])), 
	io:format("\n"),
	io:write(lab7:extractEvens([1,2])),
	io:format("\n"),
	io:write(lab7:extractEvens([2,1])),
	io:format("\n").

test1b() ->
	io:format("[~p]~n",lab7:extractAWords(["and"])),
	io:write(lab7:extractAWords(["boy"])),
	io:format("\n"),
	io:format("[~p,~p,~p]~n",lab7:extractAWords(["Acres", "boy", "and", "at"])).

test1c() ->
	io:write(lab7:logicalOR([true,true,true])),
	io:format("\n"),
	io:write(lab7:logicalOR([false,false,false])),
	io:format("\n"),
	io:write(lab7:logicalOR([true,false])),
	io:format("\n").

test1d() ->
	io:format("[~p,~p]~n",lab7:longStrings(["abc", "abcd", "ab", "a", "abcde"])),
	io:format("[~p]~n",lab7:longStrings(["abcd"])),
	%io:format("~n",lab7:longStrings([])),
	io:write(lab7:longStrings([])),
	io:format("\n").
test1e() ->
	io:format("~p~n",[lab7:strcat(["and"])]),
	io:format("~p~n",[lab7:strcat(["Hello","World"])]).

test1f() ->
	io:write(lab7:max([1.0])),
	io:format("\n"),
	io:write(lab7:max([1.0,2.0])),
	io:format("\n"),
	io:write(lab7:max([2.0,1.0,3.0])),
	io:format("\n").

getStringTree() -> 
#binaryTree{rootNode = #binaryTreeNode{value = "Erlang", left = #binaryTreeNode{value = "as", left = #binaryTreeNode{value = "a",left = null,right = null},right = #binaryTreeNode{value = "in",left = null,right = null}},right = #binaryTreeNode{value = "types",left = null, right = null}}}.

test2() ->
	io:write(lab7:findInTree("as", getStringTree())),
	io:format("\n"),
	io:write(lab7:findInTree("tests", getStringTree())),
	io:format("\n").

getExpression1() ->
#binaryTree{rootNode = #binaryTreeNode{value="2.0"}}.

getExpression2() ->
#binaryTree{rootNode = #binaryTreeNode{value="+",left=#binaryTreeNode{value="2.0"},right=#binaryTreeNode{value="4.0"}}}.

getExpression3() ->
#binaryTree{rootNode = #binaryTreeNode{value="/",left=#binaryTreeNode{value="+", left=#binaryTreeNode{value="3.0"},right=#binaryTreeNode{value="2.0"}},right=#binaryTreeNode{value="*",left=#binaryTreeNode{value="2.0"},right=#binaryTreeNode{value="2.5"}}}}.



test3() -> 
	io:write(lab7:evaluate(getExpression1())),
	io:format("\n"),
	io:write(lab7:evaluate(getExpression2())),
	io:format("\n"),
	io:write(lab7:evaluate(getExpression3())),
	io:format("\n").

