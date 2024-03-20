# FILE: visitor.rb
# CLASS: Visitor
# PURPOSE: Primary actor in visitor design pattern
# AUTHOR(S): Isaiah Parker


# ============================================= #
# Dependencies
# ============================================= #
require './token.rb'

# Class desc: The visitor "visits" expressions and calls its corresponding visit method
class Visitor

  # ============================================= #
  # AST Printing Methods
  # ============================================= #


  # Function desc: Creates a string that represents the abstract syntax tree
  def parenthesize(name, *expr)
    # "String stream"
    ss = "(".concat(name)

    expr.each do |e|
      ss.concat(" ")
      # Calls the accept method for appropriate expression and then passes itself into it
      ss.concat(e.accept(self))
    end

    ss.concat(")")

    ss.to_s # return
  end

  # Function desc: Returns given expression in a printable format
  def print_expression(expr)
    expr.accept(self)
  end

  # ============================================= #
  # Visits
  # ============================================= #


  def visit_binary_expr(expr)
    parenthesize(expr.operator.lexeme, expr.left, expr.right) # return
  end

  def visit_unary_expr(expr)
    parenthesize(expr.operator.lexeme, expr.right) # return
  end

  def visit_literal_expr(expr)
    if expr.value == nil then return "nil" end
    expr.value.to_s # return
  end

  def visit_grouping_expr(expr)
    parenthesize("group", expr.expression) # return
  end
end

# EOF