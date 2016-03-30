/*
 * Task1.cpp
 *
 *  Created on: Mar 25, 2016
 *      Author: tobi
 */

#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <stack>
//#include <algorithm>

using namespace std;

bool isOperator(const string& c)
{
	bool isOperator = false;
	if(c == "+" || c == "-" || c == "*" || c == "/" || c == "%" || c == "(" || c == ")")
		isOperator = true;
	return isOperator;
}

bool isOperator(const char& c)
{
	bool isOperator = false;
	if(c == '+' || c == '-' || c == '*' || c == '/' || c == '%' || c == '(' || c == ')')
	{
		isOperator = true;
	}
	return isOperator;
}

bool isEqualSign(const string& s)
{
	return s == "=" ? true : false;
}

bool isRenamingSymbol(const char& c)
{
    return c == '$' ? true : false;
}

int getPrecedence(const string& c)
{
	int prec = 0;
	if(c == "*" || c == "/" || c == "%")
		prec = 4;
	else if(c == "+" || c == "-" )
		prec = 3;
	else if(c == ")")
		prec = 2;
	else if (c == "(")
		prec = 1;
	return prec;
}

string infixToPostfix(const string& expr)
{
	string pf;
	stack<string> hlp;
	for(unsigned i = 0; i < expr.size(); i++)
	{
		string varName = expr.substr(i,1);
		if(!isOperator(varName))
		{
			for(const char c : expr)
			{
				if(!isOperator(c) || isRenamingSymbol(c))
				{
					varName += c;
				}
				else
				{
					break;
				}
			}
			pf += varName;
		}
		else if(varName == "(")
		{
			hlp.push(varName);
		}
		else
		{
			while(!hlp.empty() && getPrecedence(varName) <= getPrecedence(hlp.top()))
			{
				// c has lower priority than stack operator -> empty stack until no more higher operations are on stack
				pf += hlp.top();
				hlp.pop();
			}
			if(varName != ")")
			{
				// ignore ')' brackets -> in postfix not needed
				hlp.push(varName);
			}
			else if (hlp.top() == "(")
			{
				// delete bracket
				hlp.pop();
			}
		}
	}
	while(!hlp.empty())
	{
		pf += hlp.top();
		hlp.pop();
	}
	return pf;
}

void varRenaming(const string& filename)
{
	fstream _file(filename);
	string _completeFile{};
	string _line{};
	map<string,unsigned> _varTable{};

	if(_file.good() == true)
	{
		//set readPos to first character
		_file.seekg(0);
		while(!_file.eof())
		{
			getline(_file, _line);
			size_t pos = _line.find('=');
			if(pos != string::npos)
			{
				// do the right side of "="
				string varName{};
				for(unsigned i = pos+1; i < _line.size() - 1; i++)
				{
					if(!isOperator(_line.substr(i,1)))
					{
						varName += _line[i];
					}
					else if(varName.size() > 0)
					{
						auto it = _varTable.find(varName);
						if(it != _varTable.end())
						{
							for(unsigned j = 0; j < it->second; j++)
							{
								_line.insert(i, "$");
							}
						}
						varName.clear();
					}
				}
				//get the varName from the left side and add the "$" to the map and the string
				varName = _line.substr(0,pos);
				auto it = _varTable.find(varName);
				if(it == _varTable.end())
				{
					//value found for first time
					_varTable.insert(pair<string, unsigned>(varName,1));
					it = _varTable.find(varName);
				}
				else
				{
					//value was already in the map
					it->second++;
				}
				for(unsigned i = 0; i < it->second; i++)
				{
					_line.insert(pos, "$");
				}
			}
			_completeFile += _line;
			_completeFile += "\n";
		}
		// close and reopen file to write the changes
		_file.close();
		_file.open(filename.c_str(), ios::out);
		_file.write(_completeFile.c_str(),_completeFile.size());
		_file.close();
	}
	else
	{
		//Error -> dont care
	}
}


int main()
{
	//varRenaming("WorkingFile.c");

	//string infix = "(a*b)+c/d*(e+f)";
	//cout << infixToPostfix(infix) << endl;;

	cout << "Finished" << endl;
	return 0;
}


