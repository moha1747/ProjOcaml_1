// %token <string> NAME
// %token <string> VARS
// %token <int> INT
// %token <bool> TRUE
// %token <bool> FALSE

{
    open Ast
}
%token LPAREN
%token RPAREN
%token EOF



%start main           
%type <expression list> main
%%
main:
| e = expression ; EOF { [e] }
expression:
| nm = IDENT { Identifier nm }