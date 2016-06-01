#!/usr/bin/env python

# use 4 spaces as a tabulator

from bidict import bidict

expression = ""

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

class node():
    def __init__(self, label):
        self.__right = None
        self.__left = None
        self.__label = label
        self.__counter = 0
        self.__rootcounter = 0
        
    def set_left(self, left):
        self.__left = left
        
    def set_right(self, right):
        self.__right = right
        
    def set_label(self, label):
        self.__label = label
        
    def get_label_without_sharp(self):
        pass
        
    def print_graphviz(self, symbol_table):
        def make_header(gs):
            gs += "digraph G {\n"
            return gs
            
        def make_footer(gs):
            gs += "}"
            return gs
            
        def make_elements(node, gs, root):
            try:
                root.__rootcounter += 1
                node.__counter = root.__rootcounter
                gs += "N" + str(node.__counter)
                gs += '[label="' + (node.__label if is_operator(node.__label) else symbol_table.inv[node.__label]) + '"]\n'
                # first node MUST be the left node!! graphviz is shifting existing nodes to left if a new node should be inserted.
                # if first node to execute is the right, the order for some operations (-,/) is wrong
                if node.__left:
                    gs += "N" + str(node.__counter) + " -> N" + str(root.__rootcounter + 1) + "\n"
                    gs = make_elements(node.__left, gs, root)
                if node.__right:
                    gs += "N" + str(node.__counter) + " -> N" + str(root.__rootcounter + 1) + "\n"
                    gs = make_elements(node.__right, gs, root)
            except KeyError, e:
                print "Key Error"
                print e
            return gs
        
        graph_string = make_header("")
        graph_string = make_elements(self, graph_string, self)
        return make_footer(graph_string)

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

def is_end_operator(operator):
    if operator == ';':
        return True
    return False

def variable_renaming(string_to_rename_variables):
    """
    do a renaming for the variables in a text. 
    cannot work with control structures like if,for,main etc.
    only works with the plain calculate structures
    also builds a symbol table with the originally variable names and the readable substitution
    """
    new_file_string = ""
    variables = {}
    symbol_table = bidict()
    var_counter = 0
    for line in string_to_rename_variables:
        variable = ""
        # do some stuff with each line
        line = line.lstrip('\r\n ')
        line = line.rstrip('\r\n ')
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
                        this_var_counter = (0 if variable not in variables else variables[variable])
                        variables[variable] = this_var_counter + 1 #i have this variable at least one time at the left side. so this is not the same variable, if i see it on the right side
                        left_side_variable = variable
                        for i in range(this_var_counter + 1): #adding the $ d
                            variable += '$'
                    else:
                        # the right side of the assignment
                        if variable in variables:
                            for i in range(variables[variable] - (1 if left_side_variable == variable else 0)):
                                # do this -1 times if the variable was the left side operator, because the counter of the variable was incremented
                                variable += '$'
                        else:
                            variables[variable] = 0 # zeroing variable for next one
                    # now make the symbol table and look, if the variable is in the symbol table
                    if not variable in symbol_table:
                        var_counter += 1
                        symbol_table[variable] = "#" + str(var_counter)
                    variable = symbol_table[variable]
                    
                new_file_string += variable + ("\n" if is_end_operator(sign) else (sign if is_operator(sign) else ""))
                variable = ""
        left_side_variable = ""
    return new_file_string, symbol_table
                
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

def build_symbol_pairs(string_to_find_pairs):
    """
    build a list of pairs which contains a pair consists of the target variable and the expression to calculate this
    """
    pairs = []
    for line in string_to_find_pairs.split('\n'):
        if line != '':
            pair = line.split('=')
            pairs.append(pair)
    return pairs
        
def createTree():
    global expression
    v = str(expression[-1])
    dfg_node = node(v)
    expression = expression[:-1]
    if not is_operator(v):
        sign = v
        i = len(expression)
        while sign != '#':
            i -= 1
            sign = expression[i]
            v += sign
            expression = expression[:-1]
        v = v[::-1]
        dfg_node.set_label(v)
        return dfg_node
    
    dfg_node.set_right(createTree())
    dfg_node.set_left(createTree())
    return dfg_node

def main():
    global expression
    exp = ""
    read_file = open("datei.c")
    write_file = open("other_datei.c", "w")
    renamed_expressions, symbol_table = variable_renaming(read_file)
    file_string = ""
    pairs =  build_symbol_pairs(renamed_expressions)
    for pair in pairs:
        expression = InfixToPostifx(pair[1])
        exp = expression
        dfg = createTree()
        gs =  dfg.print_graphviz(symbol_table)
        wf = open(symbol_table.inv[pair[0]] + ".dot", "w")
        wf.write(gs)
        wf.close()
        file_string += pair[0] + "=" + exp + '\n'
    write_file.write(file_string)
    write_file.close()

if __name__ == "__main__":
    main()
