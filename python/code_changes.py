#!/usr/bin/env python

# use 4 spaces as a tabulator

def is_operator(operator):
    if (operator == '+' or 
        operator == '/' or 
        operator == '*' or 
        operator == '-' or
        operator == '(' or 
        operator == ')' or 
        operator == ';' or
        is_equal_sign(operator)):
        return True
    return False

def is_equal_sign(operator):
    if operator == '=':
        return True
    return False

def variable_renaming(string_to_rename_variables):
    new_file_string = ""
    variables = {}
    for line in string_to_rename_variables:
        variable = ""
        # do some stuff with each line
        line.lstrip('\r\n ')
        line.rstrip('\r\n ')
        left_side_variable = "" #for knowing what variable is on the left side of the operation
        for sign in line:
            if not is_operator(sign):
                variable += sign
            else:
                #removing whitespaces at begin and end
                variable = variable.lstrip()
                variable = variable.rstrip()
                if variable != "":
                    if is_equal_sign(sign):
                        # do some stuff with the one variable on the left side of the operation
                        var_counter = (0 if variable not in variables else variables[variable])
                        variables[variable] = var_counter + 1 #i have this variable at least one time at the left side. so this is not the same variable, if i see it on the right side
                        left_side_variable = variable
                        for i in range(var_counter + 1): #adding the $ d
                            variable += '$'
                    else:
                        # the right side of the assignment
                        if variable in variables:
                            for i in range(variables[variable] - (1 if left_side_variable == variable else 0)):
                                # do this -1 times if the variable was the left side operator, because the counter of the variable was incremented
                                variable += '$'
                        else:
                            variables[variable] = 0
                # zeroing variable for next one
                new_file_string += variable + sign if is_operator(sign) else ""
                variable = ""
        new_file_string += "\n"
        left_side_variable = ""
    return new_file_string
                

def main():
    read_file = open("datei.c")
    write_file = open("other_datei.c", "w")
    write_file.write(variable_renaming(read_file))

if __name__ == "__main__":
    main()