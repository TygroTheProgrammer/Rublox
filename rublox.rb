# FILE: rublox.rb
# CLASS: Lox
# PURPOSE: Handles the processing of the Lox language
# AUTHOR(S): Isaiah Parker

# ============================================= #
# Dependencies
# ============================================= #
require './scanner.rb'
require './token.rb'



# Class desc: Handles the processing of the Lox language
class Lox

  # ============================================= #
  # Class Variables
  # ============================================= #

  # Error flag
  @@had_error = false

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

    # Closes REPEL/script if error is found
    if (@@had_error == true)
      exit()
    end

    # Set up scanner
    scanner = Scanner.new(src, self)

    # Get all tokens
    tokens = scanner.scan_all_tokens

    # Prints each token
    tokens.each { |tkn|
      puts tkn
    }
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
      @@had_error = false
    end

  end


  # ============================================= #
  # Error Handling
  # ============================================= #

  # Function desc: Handles errors
  def error(line, column, message)
    report(line, column,"", message)
  end

  # Function desc: Displays errors
  def report(line, column, where, message)
    puts("[line #{line}] [column #{column}] Error #{where}  : #{message}")
    @@had_error = true
  end

end


program = Lox.new

# Runs Lox
program.main


# EOF
