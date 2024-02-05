require './token.rb'

class Scanner
  def initialize(src_string)
    @src = src_string.chars
    @tokens = []
    @start_pos = 0
    @next_pos = 0
    @line = 1
  end

  def is_at_end
    return (@next_pos >= @src.length)
  end

  # Helper Functions

  def advance
    current_char = @src[@next_pos]
    @next_pos += 1
    return current_char
  end


  def add_token(* args)
    text = @src[@start_pos]

    if text == "\n"
      text = '\n'
    end
    case args.size
    when 1
      @tokens.append(Token.new(args[0], text, nil, @line))
    when 2
      @tokens.append(Token.new(args[0], text, args[1], @line))
    end
  end


  # Assigns each detected token a value
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
    when "\n"
      add_token(TOKEN_TYPE::NEW_LINE)
      @line += 1
    end

  end

  def scan_all_tokens
    while (!is_at_end)
      @start_pos = @next_pos
      scan_token
    end
    @tokens.append(Token.new(TOKEN_TYPE::EOF, "", nil, @line))

    return @tokens

  end

end
