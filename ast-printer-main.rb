
require './expr.rb'
def main
  expression = BinaryExpr.new(
    UnaryExpr.new(Token.new(TOKEN_TYPE::MINUS, "-", nil, 1, 1),
              LiteralExpr.new(123)),
    Token.new(TOKEN_TYPE::STAR, "*", nil, 1, 1),
    GroupingExpr.new(
      LiteralExpr.new(46.67)))


  printer = Visitor.new
  print(printer.print_expression(expression))
end

main

