# FILE: rublox.rb
# CLASS: Lox
# PURPOSE: Handles the processing of the Lox language
# AUTHOR(S): Isaiah Parker

# ============================================= #
# Dependencies
# ============================================= #
require './scanner.rb'
require './token.rb'
require './parser.rb'
require './interpreter.rb'

# Class desc: Handles the processing of the Lox language
class Lox

  # ============================================= #
  # Class Variables
  # ============================================= #

  # Error flag
  @had_error = false

  # ============================================= #
  # Primary Lox Functions
  # ============================================= #
  def main
    # Handles too many arguments
    if ARGV.length > 1
      puts("Usage: rublox.rb [script]")
    elsif ARGV.length == 1
      # Directly runs file in one command
      run_file(ARGV[0])
    else
      # Opens run prompt
      run_prompt
    end

  end


  # Function desc: Runs a given Lox program
  def run(src)
    # Set up scanner
    scanner = Scanner.new(src, self)

    # Get all tokens
    tokens = scanner.scan_all_tokens # the actual list of tokens

    # Gets all expressions
    parser = Parser.new(tokens, self)

    expression = parser.parse # the actual list of expressions

    # Closes REPEL/script if error is found
    if @had_error
      exit
    end

    # Creates visitor/AST printer
    ast_printer = Visitor.new


    puts(ast_printer.print_expression(expression))

    interpreter = Interpreter.new(self)

    interpreter.interpret(expression)

  end

  # Function desc: Runs a given Lox path
  def run_file(path)
    src = File.open(path).read
    run(src)
  end

  # Function desc: Prompts input
  def run_prompt
    while 1 == 1
      print("> ")
      # Gets user input
      line = gets.chomp

      if line == ""
        # Stops REPEL environment
        break
      end

      run(line)
      @had_error = false
    end

  end


  # ============================================= #
  # Error Handling
  # ============================================= #

  # Function desc: Handles errors
  def error(token, * message)
    if token == :eof
      report(line, column," at end", message)
    else
      report(token.line, token.column,"at '" + token.lexeme.to_s + "'", message)
    end
  end

  # Function desc: Displays errors
  def report(line, column, where, message)
    puts("[line #{line}] [column #{column}] Error #{where}  : #{message}")
    @had_error = true
  end
end


program = Lox.new

# Runs Lox
program.main


# EOF
