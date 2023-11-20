type expression =
  | Identifier of string
  | Int of int
  | Bool of bool
  | Var of string
  | ListExpr of expr list  
  | Append of expr * expr
  | Cons of expr * expr
  | Nil
  | Match of expr * (pattern * expr) list
  | Let of string * expr * expr
  | LetRec of string * expr * expr
  | If of expr * expr * expr
  | Lambda of string * typ * expr  
  | App of expr * expr
  | Proof of string * expr * hint option 
  | Axiom of string * expr
and pattern =
  | PVar of string
  | PCons of pattern * pattern
  | PNil
and typ =
  | IntType
  | BoolType
  | FuncType of typ * typ
  | ListType of typ
and hint =
  | Induction of string


