require './scanner.rb'
require './token.rb'



class Lox
  def main



  end



  #Wraps around the run() function
  def runFile(path)

  end

  def runPrompt

  end

  def run(src)
    scanner = Scanner.new(src)
    tokens = scanner.scanTokens()

    tokens.each { |tkn|
      puts tkn
    }
  end
end


