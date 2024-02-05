# FILE: scanner.rb
# CLASS: Scanner
# PURPOSE: Finds and parses tokens
# AUTHOR(S): Isaiah Parker

# ============================================= #
# Dependencies
# ============================================= #
require './token.rb'

# Class desc: Finds and parses tokens
class Scanner
  def initialize(src_string)

    # ============================================= #
    # Class Variables
    # ============================================= #

    @src = src_string.chars
    @token_list = []
    @start_pos = 0
    @next_pos = 0
    @line = 1
  end

  # ============================================= #
  # Helper Functions
  # ============================================= #

  # Function desc: Simple boolean method that checks if the char pointer is at the end of the program
  def is_at_end
    return (@next_pos >= @src.length)
  end


  # Function desc: Returns current char and moves char pointer to next position
  def advance
    current_char = @src[@next_pos]
    @next_pos += 1
    return current_char
  end

  # ============================================= #
  # Token Handling
  # ============================================= #


  # Function desc: Adds given token type to token_list
  # Note: Has two versions based on amount of arguments given
  def add_token(* args)
    text = @src[@start_pos]

    # Replaces literal '\n' with a text version
    if text == "\n"
      text = '\n'
    end
    case args.size
    when 1 # add_token(TOKEN_TYPE)
      @token_list.append(Token.new(args[0], text, nil, @line))
    when 2 # add_token(TOKEN_TYPE, literal_value)
      @token_list.append(Token.new(args[0], text, args[1], @line))
    end
  end


  # Function desc: Assigns each detected token a type, an adds them to the list
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

  # Function desc: Scans all tokens in given program
  def scan_all_tokens
    while (!is_at_end)
      @start_pos = @next_pos
      scan_token
    end
    @token_list.append(Token.new(TOKEN_TYPE::EOF, "", nil, @line))

    return @token_list

  end

end

# EOF
