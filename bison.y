%{


#include stdio.h
#include stdlib.h
extern int yylex();
extern int yyparse();
#ifdef YYDEBUG
  yydebug = 1;
#endif
extern FILE* yyin;
void yyerror(const char* s);
%}

%union {
  int tk_int;
  char *tk_id;
}

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

%start program

%%

program : tk_program identifier tk_dot_comma block tk_dot tk_over tk_out 
        ;


identifier : tk_id 
           letter_or_digit
           ;

letter_or_digit : tk_id 
                | tk_int 
                ;


    block : type_definition_part 
          variable_declaration_part 
          procedure_declaration_part 
          statement_part
          ;

        type_definition_part : empty 
                            | tk_type type_definition
                            ;

            type_definition : identifier tk_equal type
                            ;

                type : simple_type
                    ;

                    simple_type : scalar_type 
                                | type_identifier
                                ;

                        type_identifier : identifier
                                        ;

                        scalar_type : tk_openbrac 
                                    identifier 
                                    tk_closebrac
                                    ;

        variable_declaration_part : empty 
                                | tk_var variable_declaration 
                                ;

            variable_declaration : identifier tk_twopoints type
                                ;

        procedure_declaration_part : procedure_declaration
                                    ;

            procedure_declaration : procedure_heading block
                                    ;

                procedure_heading : tk_procedure identifier tk_dot_comma |
                                tk_procedure 
                                identifier 
                                tk_openbrac 
                                formal_parameter_section  
                                tk_closebrac
                                tk_dot_comma
                                ;

                    formal_parameter_section : parameter_group 
                                            | tk_var parameter_group 
                                            | tk_procedure identifier
                                            ;

                        parameter_group : identifier tk_twopoints type_identifier
                                        ;

        statement_part : compound_statement
                       ;

            compound_statement : tk_begin statement tk_end tk_dot_comma 
                               ;

                statement : unlabelled_statement

                    unlabelled_statement : simple_statement 
                                        | structured_statement
                                        ;

                        simple_statement : assignment_statement 
                                         | procedure_statement 
                                         | empty
                                         ;

                            assignment_statement : variable tk_assigment expression
                                                 ;

                                variable : identifier
                                

                                expression : simple_expression 
                                           | simple_expression relational_operator simple_expression
                                           ;

                                    relational_operator : tk_equal 
                                                        | tk_different
                                                        | tk_smaller
                                                        | tk_smaller_equal 
                                                        | tk_greter_equal 
                                                        | tk_bigger
                                                        ;

                                    simple_expression : term 
                                                      | sign term
                                                      | simple_expression adding_operator term
                                                      ;

                                        sign : tk_plus 
                                             | tk_minus
                                             ;

                                        adding_operator : tk_plus 
                                                        | tk_minus 
                                                        | tk_or
                                                        ;

                                        term : factor 
                                             | term multiplying_operator factor
                                             ;

                                            factor : variable 
                                                   | tk_openbrac expression tk_closebrac 
                                                   | tk_not factor
                                                   ;

                                        multiplying_operator : tk_times 
                                                             | tk_division 
                                                             | tk_mod 
                                                             | tk_and
                                                             ;

                            
                        procedure_statement : identifier 
                                            | identifier tk_openbrac actual_parameter tk_closebrac
                                            ;

                            actual_parameter : expression 
                                             | variable 
                                             | identifier
                                             ;

                        empty :
                              ;

                    structured_statement : compound_statement 
                                         | conditional_statement 
                                         | repetitive_statement
                                         ;

                        compound_statement : tk_begin statement 
                                           tk_end 
                                           tk_dot_comma
                                           ;

                        conditional_statement : if_statement
                                              ;

                            if_statement : tk_if expression tk_then statement 
                                         | tk_if expression tk_then statement tk_else statement
                                         ;
                        
                        repetitive_statement : while_statement
                                             ; 

                            while_statement : tk_while expression tk_do statement
                                            ;

%%
#include

int yyparse(void);

int main(void)
{
    # if YYDEBUG == 1
    extern int yydebug;
    yydebug = 1;
    #endif

    return yyparse();
}

void yyerror(char *error_message)
{
    fprintf(stderr, "Error: %s\nExiting\n", error_message);
}              