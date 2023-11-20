{
  open Lexing
  (* open Parser The type token is defined in parser.mli *)
  exception SyntaxError of string
  exception EOF


}

let digit = ['0'-'9']
let integer = digit+
let letter = ['a'-'z' 'A'-'Z']
let identifier = letter (letter | digit | '_')*
let newline = '\r' | '\n' | "\r\n"

let comment_start = "(*"
let comment_end = "*)"
let prove_annotation = "prove"
let hint_annotation = "hint:"

rule token = parse
  | [' ' '\t'] { token lexbuf}
  | newline { Lexing.newline lexbuf; token lexbuf }
  | integer as lxm { INT (int_of_string lxm) }
  | "true" { TRUE }
  | "false" { FALSE }
  | "==" { EQUALS }
  | "&&" { AND }
  | "func" { FUNC }
  | "go" { GO }
  | "<-" { SEND }
  | "newChannel" { NEWCHANNEL }
  | ":=" { DECLARE }
  | "while" { WHILE }
  | "if" { IF }
  | "else" { ELSE }
  | "return" { RETURN }
  | "print" { PRINT }
  | "int" { INTTYPE }
  | "bool" { BOOLTYPE }
  | "chan int" { CHANINTTYPE }
  | '+' { PLUS }
  | '-' { MINUS }
  | '*' { TIMES }
  | '/' { DIV }
  | '>' { GT }
  | '!' { NOT }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | '{' { LBRACE }
  | '}' { RBRACE }
  | ';' { SEMICOLON }
  | ',' { COMMA }
  | '=' { ASSIGN }
  | identifier as lxm { IDENT lxm }
  | comment_start { read_comment lexbuf }
  | _ { raise (SyntaxError("Unexpected character: " ^ Lexing.lexeme lexbuf)) }
  | eof { EOF }
and read_comment = parse
  | comment_end { token lexbuf }
  | prove_annotation comment_end { PROVE }
  | hint_annotation as hint { read_hint hint lexbuf }
  | _ { read_comment lexbuf }
and read_hint hint = parse
  | comment_end { HINT hint }
  | _ { read_hint (hint ^ Lexing.lexeme lexbuf) lexbuf }
