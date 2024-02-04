require './token.rb'

class Scanner
  def initialize(path)
    @src = File.open(path).read.split("")
    @tokens = []
    @start = 0
    @current = 0
    @line = 1
    # File.close(scan_src)
  end

  def is_at_end
    return (@current >= @src.length)
  end

  # Helper Functions

  def advance
    current_char = @src[@current]
    @current += 1
    return current_char
  end


  def add_token(* args)
    text = @src[@start..@current]
    case args.size
    when 1
      @tokens.append(Token.new(args[0], text, nil, @line))
    when 2
      @tokens.append(Token.new(args[0], text, args[1], @line))
    end
  end

  def scan_token
    c = advance
    case c
    when '('
      add_token(TOKEN_TYPE::LEFT_PAREN)
    when ')'
      add_token(TOKEN_TYPE::RIGHT_PAREN)
    when '{'
      add_token(TOKEN_TYPE::LEFT_BRACE)
    when '}'
      add_token(TOKEN_TYPE::RIGHT_BRACE)
    when ','
      add_token(TOKEN_TYPE::COMMA)
    when '.'
      add_token(TOKEN_TYPE::DOT)
    when '-'
      add_token(TOKEN_TYPE::MINUS)
    when '+'
      add_token(TOKEN_TYPE::PLUS)
    when ';'
      add_token(TOKEN_TYPE::SEMICOLON)
    when '*'
      add_token(TOKEN_TYPE::STAR)
    end

  end

  def scan_tokens
    while (!is_at_end)
      @start = @current
      scan_token
    end
    @tokens.append(Token.new(TOKEN_TYPE::EOF, "", nil, @line))

    return @tokens

  end



end





