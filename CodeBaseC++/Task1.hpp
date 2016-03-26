/*
 * Task1.hpp
 *
 *  Created on: Mar 25, 2016
 *      Author: tobi
 */

#ifndef TASK1_HPP_
#define TASK1_HPP_

bool isOpertor(const char c);
bool isEqualSign(const char c);
int getPrecedence(const char c);
std::string infixToPostfix(const std::string expr);
void varRenaming(const std::string filename);



#endif /* TASK1_HPP_ */
