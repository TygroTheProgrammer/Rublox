require './scanner.rb'
require './token.rb'



class Lox

  @@had_error = false
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



  # Runs specified Lox path
  def run(path)
    if (@@had_error == true)
      exit()
    end
    scanner = Scanner.new(path)
    tokens = scanner.scan_tokens

    tokens.each { |tkn|
      puts tkn
    }
  end

  # Wraps around the run() function
  def run_file(path)
    run(path)
  end

  # Prompts input
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

  def error(line, message)
    report(line, "", message)
  end


  def report(line, where, message)
    puts("[line #{line}] Error #{where}  : #{message}")
    @@had_error = true
  end

end





program = Lox.new

program.main