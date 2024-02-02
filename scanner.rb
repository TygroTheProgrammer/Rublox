require './token.rb'

class Scanner

  def initialize(scan_src)
    @src = File.open(scan_src)
    @char_list = @src.read.split("")
    @current_idx = 0
    @start_idx = 0
    @token_list = []

  end


  def scanTokens()


    for c in char_list

    end

  end






end





