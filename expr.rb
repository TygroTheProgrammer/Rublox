# FILE: expr.rb
# CLASS: Expression
# PURPOSE: Manages Lox Expressions
# AUTHOR(S): Isaiah Parker


# ============================================= #
# Dependencies
# ============================================= #
require './visitor.rb'



# Class desc: Primary parent of all expressions
class Expr
  # Function desc: Do nothing
  def accept; end
end


# ============================================= #
# Expression Types/Subclasses
# ============================================= #


# Class desc: Binary expression [expression] [operator] [expression]
class BinaryExpr < Expr

  # Simple Accessor Methods
  attr_reader :left, :operator, :right

  def initialize(left, operator, right)

    # ============================================= #
    # Class Variables
    # ============================================= #

    # Expression to the left of operator
    @left = left
    # Operator in the middle of expression
    @operator = operator
    # Expression to the right of operator
    @right = right
  end

  # Function desc: calls corresponding visit method and passes itself into it
  def accept(visitor)
    visitor.visit_binary_expr(self)
  end
end


# Class desc: Grouping expression ([expression])
class GroupingExpr < Expr


  attr_reader :expression

  def initialize(expression)

    # ============================================= #
    # Class Variables
    # ============================================= #

    # This expression is wrapped in parenthesis
    @expression = expression
  end

  # Function desc: calls corresponding visit method and passes itself into it
  def accept(visitor)
    visitor.visit_grouping_expr(self)
  end

end


# Class desc: Unary expression [operator] [expression]
class UnaryExpr < Expr
  attr_accessor :operator, :right

  def initialize(operator, right)

    # ============================================= #
    # Class Variables
    # ============================================= #

    # Operator that is "attached" to expression
    @operator = operator
    # Expression that has the operator "attached" to it
    @right = right
  end

  # Function desc: calls corresponding visit method and passes itself into it
  def accept(visitor)
    visitor.visit_unary_expr(self)
  end

end


# Class desc: Literal expression [value]
class LiteralExpr < Expr
  attr_accessor :value

  def initialize(value)

    # ============================================= #
    # Class Variables
    # ============================================= #

    # Contains some form of token or literal value
    @value = value
  end

  # Function desc: calls corresponding visit method and passes self into it
  def accept(visitor)
    visitor.visit_literal_expr(self)
  end
end

# EOF