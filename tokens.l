%{
#include <string>
#include "node.h"
#include "parser.hpp"
#define SAVE_TOKEN yylval.string = new std::string(yytext, yyleng)
//#define TOKEN(t) (yylval.token = t)
extern "C" int yywrap() { }
%}

%%

[ \t\n]                 ;
"begin"				    {return tk_begin;}
"program"				{return tk_program ;}
"and"					{return tk_and ;}
"do"				    {return tk_do ;}
"else"				    {return tk_else ;}
"end"					{return tk_end ;}
"false"				    {return tk_false;}
"if"				    {return tk_if ;}
"integer"				{return tk_integer ;}
"main"				    {return tk_main ;}
"not"					{return tk_not;}
"or"				    {return tk_or ;}
"procedure"				{return tk_procedure ;}
"string"				{return tk_string ;}
"then"				    {return tk_then ;}
"type"				    {return tk_type ;}
"true"				    {return tk_true;}
"var"					{return tk_var ;}
"while"				    {return tk_while ;}
"boolean"               {return tk_boolean;}

"over"                  {return tk_over;}
"out"                   {return tk_out;}

"*"						{return tk_times;}
"+"						{return tk_plus;}
"-"						{return tk_minus;}
"/"						{return tk_division;}
"%"						{return tk_mod;}

"="						{return tk_equal;} 
"("						{return tk_openbrac;}
")"						{return tk_closebrac;}
"["						{return tk_openclasp;}
"]"						{return tk_closeclasp;}
","						{return tk_comma;}
":"						{return tk_twopoints;}
";"					    {return tk_dot_comma;}
">"						{return tk_bigger;}
"<"						{return tk_smaller;}
">="					{return tk_greter_equal;}
"<="					{return tk_smaller_equal;}
"<>"					{return tk_different;}
":="					{return tk_assigment;}
"."						{return tk_dot;}
".."					{return tk_dot_dot;}


[a-zA-Z_][a-zA-Z0-9_]*  {SAVE_TOKEN,return tk_id;};
[0-9]+      			{SAVE_TOKEN,return tk_int;}

.                       printf("Unknown token!n"); yyterminate();

%%