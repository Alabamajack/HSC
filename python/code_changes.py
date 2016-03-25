#!/usr/bin/env python

# use 4 spaces as a tabulator

class stack(list):
    def top(self):
        c = self.pop()
        self.append(c)
        return c
    def is_empty(self):
        if len(self) > 0:
            return False
        return True
    def push(self,c):
        self.append(c)

def is_operator(operator):
    if (operator == '+' or 
        operator == '/' or 
        operator == '*' or 
        operator == '-' or
        operator == '(' or 
        operator == ')' or 
        operator == ';' or
        operator == '%' or
        is_equal_sign(operator)):
        return True
    return False

def get_Operator_Precedence(operator):
    if (operator == '*' or
        operator == '/' or
        operator == '%'):
        return 3
    elif (operator == '+' or
          operator == '-'):
        return 2
    elif operator == ')':
        return 1
    elif operator == '(':
        return 0
    else:
        return 0

def is_equal_sign(operator):
    if operator == '=':
        return True
    return False

def variable_renaming(string_to_rename_variables):
    """
    do a renaming for the variables in a text. 
    cannot work with control structures like if,for,main etc.
    only works with the plain calculate structures
    """
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
                
def InfixToPostifx(infix):
    """
    do a InfixToPostfix conversion for a expression
    can also handle expressions like a=b+c;
    """
    operator_stack = stack()
    postfix = ""
    for sign in infix:
        if not is_operator(sign) or sign == '=':
            postfix += sign
        elif sign == '(':
            operator_stack.push(sign)
        else:
            while (not operator_stack.is_empty()) and (get_Operator_Precedence(sign) <= get_Operator_Precedence(operator_stack.top())):
                if operator_stack.top() == '(':
                    operator_stack.pop()
                    continue
                postfix += operator_stack.pop()
            if sign != ')':
                operator_stack.push(sign)
            elif operator_stack.top() == '(':
                operator_stack.pop()
    while not operator_stack.is_empty():
        if operator_stack.top() == '(':
            operator_stack.pop()
            continue
        postfix += operator_stack.pop()
    return postfix

def main():
    read_file = open("datei.c")
    write_file = open("other_datei.c", "w")
    renamed_expressions = variable_renaming(read_file)
    file_string = ""
    for line in renamed_expressions.split('\n'):
        file_string += InfixToPostifx(line)
        file_string += '\n'
    write_file.write(file_string)
    write_file.close()

if __name__ == "__main__":
    main()