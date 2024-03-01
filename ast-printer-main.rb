# FILE: ast-printer-main.rb
# PURPOSE: Tests and prints a AST
# AUTHOR(S): Isaiah Parker

require './expr.rb'
def main
  # Expression: -123 * (46.67)
  expression = BinaryExpr.new(
    UnaryExpr.new(Token.new(TOKEN_TYPE::MINUS, "-", nil, 1, 1),
              LiteralExpr.new(123)),
    Token.new(TOKEN_TYPE::STAR, "*", nil, 1, 1),
    GroupingExpr.new(
      LiteralExpr.new(46.67)))


  # Create AST Printer
  printer = Visitor.new
  print(printer.print_expression(expression))
end


# Run program
main

# EOF