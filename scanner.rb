require './token.rb'

class Scanner

  # Local Variables

  def initialize(scan_src)
    @src = File.open(scan_src)
    @char_list = @src.read.split("")
    @current_idx = 0
    @start_idx = 0
    @token_list = []

  end


  # Functions

  def scanToken()

    for c in char_list

  end

  def scanNextToken()

  end

  def addToken(tkn)
    @token_list.append(tkn)
  end

end
