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
  def initialize(src_string, lox)

    # ============================================= #
    # Class Variables
    # ============================================= #

    @src = src_string
    @lox_out = lox
    
    @token_list = []
    
    @start_pos = 0
    @next_pos = 0
    
    
    @line_pos = 1
    @col_pos = 0

    @end_of_file = false
    @end_of_line = false
    
  end

  # ============================================= #
  # Helper Functions
  # ============================================= #

  # Function desc: Simple boolean method that checks if the char pointer is at the end of the program
  def is_at_end
    return (@next_pos >= @src.length)
  end

  # Function desc: Moves char pointer to next position
  def advance_pos

    @next_pos += 1
    @col_pos += 1
  end

  # Function desc: Returns current char and moves char pointer to next position
  def grab_advance
    current_char = @src[@next_pos]

    advance_pos

    return current_char
  end

  def match(expected)
    if (is_at_end)
      return false
    end

    if (@src[@next_pos] != expected)
      return false
    end
    advance_pos
    
    return true
  end

  # Function desc: Returns the next character without consuming it
  def peek
    if is_at_end
      return "\0"
    end
    return @src[@next_pos]
  end

  # ============================================= #
  # Literal Handling
  # ============================================= #

  def make_string_literal
    
  end


  # ============================================= #
  # Token Handling
  # ============================================= #


  # Function desc: Adds given token type to token_list
  # Note: Has two versions based on amount of arguments given
  def add_token(* args)
    text = ""
    for c in @start_pos..(@next_pos - 1) do
      text += @src[c].to_s
    end

    # Replaces literal '\n' with a text version
    if text == "\n"
      text = '\n'
    end
    case args.size
    when 1 # add_token(TOKEN_TYPE)
      @token_list.append(Token.new(args[0], text, nil, @line_pos, @col_pos))
    when 2 # add_token(TOKEN_TYPE, literal_value)
      @token_list.append(Token.new(args[0], text, args[1], @line_pos, @col_pos))
    end
  end


  # Function desc: Assigns each detected token a type, an adds them to the list
  def scan_token
    c = grab_advance
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
    when '!'
      add_token(match('=') ? TOKEN_TYPE::BANG_EQUAL : TOKEN_TYPE::BANG)
    when '='
      add_token(match('=') ? TOKEN_TYPE::EQUAL_EQUAL : TOKEN_TYPE::EQUAL)
    when '<'
      add_token(match('=') ? TOKEN_TYPE::LESS_EQUAL : TOKEN_TYPE::LESS)
    when '>'
      add_token(match('=') ? TOKEN_TYPE::GREATER_EQUAL : TOKEN_TYPE::GREATER)
    when '/'
      if match('/')
        # Consumes every character on line with comment
        while (peek != "\n" && !is_at_end)
          advance_pos
        end
      else
        add_token(TOKEN_TYPE::SLASH)
      end
    when ' ',"\r","\t"
    when "\n"
      # add_token(TOKEN_TYPE::NEW_LINE)
      @line_pos += 1
      @col_pos = 0
    when '"'

    else
      @lox_out.error(@line_pos, @col_pos, "Unexpected character")
    end


  end

  # Function desc: Scans all tokens in given program
  def scan_all_tokens
    while (!is_at_end)
      @start_pos = @next_pos
      scan_token
    end
    @token_list.append(Token.new(TOKEN_TYPE::EOF, "", nil, @line_pos, @col_pos))

    return @token_list

  end

end

# EOF