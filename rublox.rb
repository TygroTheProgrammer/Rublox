require './scanner.rb'
require './token.rb'



class Lox
  def main
    if ARGV.length > 1
      puts("Usage: rublox [script]")
    elsif ARGV.length == 1

      runFile(ARGV[0])
    else
      runPrompt
    end



  end

  def run(src)
    scanner = Scanner.new(src)
    tokens = scanner.scanTokens

    tokens.each { |tkn|
      puts tkn
    }
  end

  #Wraps around the run() function
  def runFile(path)

  end

  def runPrompt



    while 1 == 1
      print("> ")
      line = gets.chomp

      if line == nil
        break
      end
      run(line)



    end

  end


end



program = Lox.new

program.main