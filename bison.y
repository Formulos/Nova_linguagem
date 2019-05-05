%{
#include stdio.h
#include stdlib.h
extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}

%token<int> tk_int
%token<id> tk_id
%token tk_begin
%token tk_program
%token tk_and
%token tk_do
%token tk_else
%token tk_end
%token tk_false
%token tk_if
%token tk_integer
%token tk_main
%token tk_not
%token tk_or
%token tk_procedure
%token tk_string
%token tk_then
%token tk_type
%token tk_true
%token tk_var
%token tk_while
%token tk_boolean
%token tk_over
%token tk_out
%token tk_times
%token tk_plus
%token tk_minus
%token tk_division
%token tk_mod
%token tk_equal
%token tk_openbrac
%token tk_closebrac
%token tk_openclasp
%token tk_closeclasp
%token tk_comma
%token tk_twopoints
%token tk_dot_comma
%token tk_bigger
%token tk_smaller
%token tk_greter_equal
%token tk_smaller_equal
%token tk_different
%token tk_assigment
%token tk_dot
%token tk_dot_dot


program : tk_program identifier tk_dot_comma block tk_dot tk_over tk_out 
        ;

//identifier ds finds you letters and digits

identifier : letter {letter_or_digit}

letter_or_digit : tk_id 
                | tk_int 
                ;

//block: meat and bones

    block : type definition part variable declaration part procedure declaration part statement part

    //type only need scalar type; no pointers , data structures and user definede
    // scalar type = int,floats,double...

        type definition part : empty | "type" type definition {;type definition};

            type definition : identifier "=" type

                type : simple type

                    simple type : scalar type | type identifier

                        type identifier : identifier

                        scalar type : (identifier {,identifier})

        variable declaration part : empty | "var" variable declaration {; variable declaration} ;

            variable declaration : identifier {,identifier} ":" type

        //procedure equal function for my language purpose
        procedure declaration part : procedure declaration

            procedure declaration : procedure heading block

                procedure heading : procedure identifier ";" |
                procedure identifier ( formal parameter section {;formal parameter section} );

                    formal parameter section : parameter group | var parameter group |
                    function parameter group | procedure identifier { , identifier}

                        parameter group : identifier {, identifier} : type identifier

        statement part : compound statement

            compound statement : "begin" statement {; statement } "end";

                //we dont have label (no go to here)
                statement : unlabelled statement

                    unlabelled statement : simple statement | structured statement

                        simple statement : assignment statement | procedure statement |  empty

                            assignment statement : variable ":=" expression | function identifier := expression

                                //variable cant be files or pointers(unlike normal pascal)
                                variable : identifier
                                
                                function identifier : identifier

                                expression : simple expression | simple expression relational operator simple expression
                                    //does not have in
                                    relational operator : "=" | "" | "" | "=" | "=" | ""

                                    simple expression : term | sign term| simple expression adding operator term

                                        sign : + | -

                                        adding operator : + | - | or

                                        term : factor | term multiplying operator factor

                                            factor : variable  | ( expression ) | "not" factor

                                        multiplying operator : * | / | div | mod | and

                            
                        procedure statement : identifier | identifier (actual parameter {, actual parameter })

                            actual parameter : expression | variable | identifier

                        empty :

                    structured statement : compound statement | conditional statement | repetitive statement

                        compound statement : "begin" statement {; statement } "end";

                        conditional statement : if statement

                            if statement : "if" expression "then" statement | "if" expression "then" statement "else" statement
                        
                        //does not have "reapeat" or "for"
                        repetitive statement : while statement 

                            while statement : "while" expression "do" statement

int main() {
	yyin = stdin;
	do {
		yyparse();
	} while(!feof(yyin));
	return 0;
}
void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
                    