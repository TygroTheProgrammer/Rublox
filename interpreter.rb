# FILE: interpreter.rb
# CLASS: Interpreter
# PURPOSE: Interprets/evaluates Lox Expressions
# AUTHOR(S): Isaiah Parker

# ============================================= #
# Dependencies
# ============================================= #
require './expr.rb'
require './runtime_error.rb'


# Class desc: Walks through AST and generates
class Interpreter
  def initialize(lox)
    @lox = lox
  end


  # Function desc: Evaluates given expression by walking through AST
  def evaluate(expr)
    expr.accept(self) # return
  end

  # Function desc: Main API function for the interpreter
  def interpret(expr)
    begin
      value = evaluate(expr)
      puts(stringify(value))
    rescue error
      @lox.error(error)
    end
  end

  # ============================================= #
  # Helper Functions
  # ============================================= #

  # Function desc: Checks if given object is a Boolean
  def is_truthy(obj)
    # Nil is interpreted as false
    return false if obj == nil
    # !! is a simple way to check if a given Ruby object is a boolean
    return obj if !!obj == obj

    # Otherwise return true
    true # return
  end

  # Function desc: Checks if two given objects are equal
  def is_equal(a, b)
    # Handles if both objects are nil
    return true if (a == nil) && (b == nil)
    # Handles if one is nil
    return false if a == nil

    a == b # return
  end

  # Function desc: Checks if given operand is a numeric value
  def check_num_opp(operator, operand)
    return if (operand.is_a?(Float))
    raise LoxRuntimeError.new(operator, "Operand must be a number.")
  end

  # Function desc: Checks if given operands are numeric values
  def check_num_opps(operator, left, right)
    return if (left.is_a?(Float) && right.is_a?(Float))
    raise LoxRuntimeError(operator, "Operands must be numbers.")
  end

  # Function desc: Converts given object into string
  def stringify(obj)
    if obj == nil
      return "nil"
    end

    if obj.is_a?(Float)
      text = obj.to_s

      if text.end_with?(".0")
        text = text[0...-2]
      end
      return text
    end
    obj.to_s
  end

  # ============================================= #
  # Visits
  # ============================================= #

  def visit_literal_expr(expr)
    expr.value # return
  end

  def visit_grouping_expr(expr)
    evaluate(expr.expression) # return
  end

  def visit_binary_expr(expr)
    left = evaluate(expr.left)
    right = evaluate(expr.right)

    case expr.operator.type
    when :minus
      return left - right
    when :slash
      return left / right
    when :star
      return left * right
    when :plus
      return (right + left) if (left.is_a?(Float) && right.is_a?(Float))
      return (left.to_s + right.to_s) if (left.is_a?(String) && right.is_a?(String))
    when :greater
      check_num_opps(expr.operator, left, right)
      return left > right
    when :greater_equal
      return left >= right
    when :less
      return left < right
    when :less_equal
      return left <= right
    when :bang_equal
      return !is_equal(left, right)
    when :equal_equal
      return is_equal(left, right)
    else
      # If the value is unreachable return null
      return nil
    end


  end

  def visit_unary_expr(expr)
    right = evaluate(expr.right)

    case expr.operator.type
    when :bang
      return is_truthy(right)
    when :minus
      return -right
    else
      # If the value is unreachable return null
      return nil
    end

  end

end