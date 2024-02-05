require './scanner.rb'
require './token.rb'



# Class desc: Handles the processing of the Lox langauge
class Lox

  # ============================================= #
  # Class Variables
  # ============================================= #

  @@had_error = false

  # ============================================= #
  # Primary Lox Functions
  # ============================================= #
  def main
    # Handles too many arguments
    if ARGV.length > 1
      puts("Usage: rublox [script]")
    elsif ARGV.length == 1
      # Directly runs file in one command
      puts(ARGV[0])
      run_file(ARGV[0])
    else
      # Opens run prompt
      run_prompt
    end

  end




  # Function desc: Runs a given Lox program
  def run(src)

    if (@@had_error == true)
      exit()
    end
    scanner = Scanner.new(src)
    tokens = scanner.scan_all_tokens

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
      line = gets.chomp

      if line == ""
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
  def error(line, message)
    report(line, "", message)
  end

  # Function desc: Displays errors
  def report(line, where, message)
    puts("[line #{line}] Error #{where}  : #{message}")
    @@had_error = true
  end

end


program = Lox.new

# Runs Lox
program.main


# EOF