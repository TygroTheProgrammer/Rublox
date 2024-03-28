# FILE: parser.rb
# CLASS: Parser
# PURPOSE: Converts a list of tokens to an AST
# AUTHOR(S): Isaiah Parker

# ============================================= #
# Dependencies
# ============================================= #
require './token.rb'
require './expr.rb'
require './stmt.rb'

# Class desc: Uses visitor pattern to generate an executable AST
class Parser

  # Class desc: Creates a specialized error type
  class ParsingError < RuntimeError
  end

  def initialize(tokens, lox)

    # ============================================= #
    # Class Variables
    # ============================================= #

    # The list of tokens to parse, usually given by the scanner
    @token_list = tokens

    # Passes in instance of the main program
    @lox = lox

    # Tracks the position of the parser in token_list
    @next_pos = 0
  end

  # Function desc: Primary function of the parser; generates an expression
  def parse
    begin # Try
      statements = []

      until is_at_end
        statements.append(statement)
      end

      return statements


    rescue ParsingError # Catches errors
      error(@token_list[@next_pos], "Parsing Error")
    end

  end
  # ============================================= #
  # Helper Functions
  # ============================================= #

  # Function desc: Simple boolean method that checks if token pointer is at the end of the program
  def is_at_end
    peek_next.type == :eof # return
  end

  # Function desc: Returns the next token in the list without consuming it
  def peek_next
    @token_list[@next_pos] # return
  end

  # Function desc: Returns the previous token in the list without consuming it
  def peek_prev
    @token_list[@next_pos - 1] # return
  end

  # Function desc: Moves the pointer forward and returns the previous token
  def advance
    unless is_at_end

      @next_pos += 1
    end
    peek_prev # return
  end

  # Function desc: Compares given token type to next token in list and returns boolean as the result
  def check(t)
    if is_at_end
      return false
    end
    peek_next.type == t # return
  end

  # Function desc: For each type given they are check()ed against the next token in the list, returning true if there's
  # a match
  def match(* types)
    types.each do |t|
      if check(t)
        advance
        return true
      end
    end

    false # return

  end
  # ============================================= #
  # Error Handling
  # ============================================= #

  # Function desc: Displays sends an error message to the main Lox program
  def error(token, message)
    @lox.error(token, message)
  end

  # Function desc: Discards tokens until the Parser is back in synch
  def synchronize
    until is_at_end
      if peek_prev.type == :semicolon
        break
      end
      case peek_next.type

      when :class

        when :fun

        when :var

      when :for

      when :if

      when :while

      when :print

      when :return
        break
      else
        # Do nothing
      end

      advance
    end
  end


  # Function desc: Consumes a given token type, otherwise send an error
  def consume(type, error_message)
    if check(type)
      return advance
    end

    error(peek_next, error_message)
  end


  # ============================================= #
  # Expression Parsing
  # ============================================= #


  def expression
    # puts("expression()...")
    equality # return
  end

  def statement
    print_statement if match(:print)
  end

  # Function desc: Adds a print statement to the statement list
  def print_statement
    value = expression
    # Look for a semicolon
    consume(:semicolon, "Expect ';' after value.")
    Stmt::Print.new(value) # return
  end

  # Function desc: Adds an expression statement to the statement list
  def expression_statement
    expr = expression
    # Look for a semicolon
    consume(:semicolon, "Expect ';' after value.")
    Stmt::Expression.new(expr) # return
  end

  def primary
    # puts("primary()...")

    # Handles literals with "simple" values
    return LiteralExpr.new(true) if match(:true)
    return LiteralExpr.new(false) if match(:false)
    return LiteralExpr.new(nil) if match(:nil)


    # Handles literals with "complex" values
    return LiteralExpr.new(peek_prev.literal) if match(:number, :string)


    if match(:left_paren)

      # The grouped expression
      expr = expression

      # Looks for corresponding ')' otherwise throw an error
      consume(:right_paren, "Expected ')' after expression.")
      return GroupingExpr.new(expr)
    end

    error(peek_next, "Expect expression")
  end

  def unary
    # puts("unary()...")
    if match(:bang, :minus)
      operator = peek_prev
      right = unary
      return UnaryExpr.new(operator, right)
    end
    primary
  end

  def factor
    # puts("factor()...")
    expr = unary

    while match(:slash, :star)
      operator = peek_prev
      right = unary
      expr = BinaryExpr.new(expr, operator, right)
    end

    expr
  end

  def term
    # puts("term()...")
    expr = factor

    while match(:minus, :plus)
      operator = peek_prev
      right = factor
      expr = BinaryExpr.new(expr, operator, right)
    end
    expr
  end


  def equality
    # puts("equality()...")
    expr = comparison

    while match(:bang_equal, :equal_equal)
      operator = peek_prev
      right = comparison
      expr = BinaryExpr.new(expr, operator, right)
    end

    expr

  end

  def comparison
    # puts("comparison()...")
    expr = term
    while match(:greater, :greater_equal, :less, :less_equal)
      operator = peek_prev
      right = term
      expr = BinaryExpr.new(expr, operator, right)
    end
    expr
  end

end

# EOF