%{
#include <string>
#include "node.h"
#include "parser.hpp"
#define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)
#define TOKEN(t) (yylval.token = t)
extern "C" int yywrap() { }
%}

%%

[ \t\n]                 ;
[a-zA-Z_][a-zA-Z0-9_]*  SAVE_TOKEN; return TIDENTIFIER;
[0-9]+.[0-9]*           SAVE_TOKEN; return TDOUBLE;
[0-9]+                  SAVE_TOKEN; return TINTEGER;


and									return TOKEN (tk_and );
array								return TOKEN (tk_array );
begin								return TOKEN (tk_begin);
case								return TOKEN (tk_case );
const								return TOKEN (tk_const );
div									return TOKEN (tk_div );
do									return TOKEN (tk_do );
else								return TOKEN (tk_else );
end									return TOKEN (tk_end );
false								return TOKEN (tk_false);
file								return TOKEN (tk_file );
for									return TOKEN (tk_for );
func								return TOKEN (tk_func );
function							return TOKEN (tk_function );
if									return TOKEN (tk_if );
in									return TOKEN (tk_in );
integer								return TOKEN (tk_integer );
interrupt							return TOKEN (tk_interrupt );
label								return TOKEN (tk_label );
main								return TOKEN (tk_main );
mod									return TOKEN (tk_mod );
nil									return TOKEN (tk_nil );
nit									return TOKEN (tk_nit );
not									return TOKEN (tk_not);
of									return TOKEN (tk_of );
or									return TOKEN (tk_or );
packed								return TOKEN (tk_packed );
procedure							return TOKEN (tk_procedure );
progr								return TOKEN (tk_progr );
program								return TOKEN (tk_program );
record								return TOKEN (tk_record );
repeat								return TOKEN (tk_repeat );
set									return TOKEN (tk_set );
shl									return TOKEN (tk_shl );
shr									return TOKEN (tk_shr );
string								return TOKEN (tk_string );
then								return TOKEN (tk_then );
to									return TOKEN (tk_to );
type								return TOKEN (tk_type );
true								return TOKEN (tk_true);
unit								return TOKEN (tk_unit );
until								return TOKEN (tk_until );
uses								return TOKEN (tk_uses );
var									return TOKEN (tk_var );
while								return TOKEN (tk_while );
with								return TOKEN (tk_with );
xor									return TOKEN (tk_xor );
boolean                             return TOKEN (tk_boolean);

over                                return TOKEN(tk_over);
out                                 return TOKEN(tk_out);

"*"									return TOKEN (tk_times);
"+"									return TOKEN (tk_plus);
"-"									return TOKEN (tk_minus);
"/"									return TOKEN (tk_division);
"%"									return TOKEN (tk_mod);

[0-9]+      						return TOKEN (tk_int);

"="									return TOKEN (tk_equal); 
"("									return TOKEN (tk_openbrac);
")"								    return TOKEN (tk_closebrac);
"["									return TOKEN (tk_openclasp);
"]"									return TOKEN (tk_closeclasp);
","									return TOKEN (tk_comma);
":"									return TOKEN (tk_twopoints);
";"								    return TOKEN (tk_dot_comma);
">"									return TOKEN (tk_bigger);
"<"									return TOKEN (tk_smaller);
">="								return TOKEN (tk_greter_equal);
"<="								return TOKEN (tk_smaller_equal);
"<>"								return TOKEN (tk_different);
":="								return TOKEN (tk_assigment);
"."									return TOKEN (tk_dot);
".."								return TOKEN (tk_dot_dot);
[ \t]								;


"="                     return TOKEN(TEQUAL);
"=="                    return TOKEN(TCEQ);
"!="                    return TOKEN(TCNE);
"<"                     return TOKEN(TCLT);
"<="                    return TOKEN(TCLE);
">"                     return TOKEN(TCGT);
">="                    return TOKEN(TCGE);
"("                     return TOKEN(TLPAREN);
")"                     return TOKEN(TRPAREN);
""                     return TOKEN(TLBRACE);
""                     return TOKEN(TRBRACE);
"."                     return TOKEN(TDOT);
","                     return TOKEN(TCOMMA);
"+"                     return TOKEN(TPLUS);
"-"                     return TOKEN(TMINUS);
"*"                     return TOKEN(TMUL);
"/"                     return TOKEN(TDIV);
.                       printf("Unknown token!n"); yyterminate();

%%