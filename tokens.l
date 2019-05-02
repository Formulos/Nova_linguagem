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
[a-zA-Z_][a-zA-Z0-9_]*  {return tk_id;};
[0-9]+      			{return tk_int;}

"and"					{return tk_and ;}
"begin"				    {return tk_begin;}
"div"					{return tk_div ;}
"do"				    {return tk_do ;}
"else"				    {return tk_else ;}
"end"					{return tk_end ;}
"false"				    {return tk_false;}
"for"					{return tk_for ;}
"func"				    {return tk_func ;}
"function"				{return tk_function ;}
"if"				    {return tk_if ;}
"integer"				{return tk_integer ;}
"label"				    {return tk_label ;}
"main"				    {return tk_main ;}
"nil"					{return tk_nil ;} !!
"not"					{return tk_not;}
"of"				    {return tk_of ;}
"or"				    {return tk_or ;}
"procedure"				{return tk_procedure ;}
"program"				{return tk_program ;}
"set"					{return tk_set ;}
"string"				{return tk_string ;}
"then"				    {return tk_then ;}
"to"				    {return tk_to ;}
"type"				    {return tk_type ;}
"true"				    {return tk_true;}
"until"				    {return tk_until ;}
"uses"				    {return tk_uses ;}
"var"					{return tk_var ;}
"while"				    {return tk_while ;}
"boolean"               {return tk_boolean;}

"over"                  {returntk_over;}
"out"                   {returntk_out;}

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
[ \t]					;

.                       printf("Unknown token!n"); yyterminate();

%%