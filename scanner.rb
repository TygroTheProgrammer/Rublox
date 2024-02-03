require './token.rb'

class Scanner

  def initialize(scan_src)
    @src = File.open(scan_src).read.split("")
    @tokens = []
    File.close(scan_src)
  end

  def is_at_end
    return (current)
  end

  def scanTokens
    while (is_at_end)


    end

  end








end





