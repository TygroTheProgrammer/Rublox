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
    @lox = lox
    
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

  # Function desc: Acts as a conditional advance function
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

  # Function desc: Returns the character after the next character without consuming it
  def peek_next
    if (@next_pos + 1 >= @src.length)
      return "\0"
    end
    return @src[@next_pos + 1]
  end

  # Function Desc: Maps string keywords to their respective token types
  def string_to_type(string)
    keyword_map =
      {
        "and" => TOKEN_TYPE::AND,
        "class" => TOKEN_TYPE::CLASS,
        "else" => TOKEN_TYPE::ELSE,
        "false" => TOKEN_TYPE::FALSE,
        "for" => TOKEN_TYPE::FOR,
        "fun" => TOKEN_TYPE::FUN,
        "if" => TOKEN_TYPE::IF,
        "nil" => TOKEN_TYPE::NIL,
        "or" => TOKEN_TYPE::OR,
        "print" => TOKEN_TYPE::PRINT,
        "return" => TOKEN_TYPE::RETURN,
        "super" => TOKEN_TYPE::SUPER,
        "this" => TOKEN_TYPE::THIS,
        "true" => TOKEN_TYPE::TRUE,
        "var" => TOKEN_TYPE::VAR,
        "while" => TOKEN_TYPE::WHILE
      }
    keyword_map.default = TOKEN_TYPE::IDENTIFIER

    return keyword_map[string]
  end


  # Function desc: Returns a portion of the source code string
  def src_substring(start, finish)
    text = ""
    for c in start..(finish - 1) do
      text += @src[c].to_s
    end
    return text
  end


  # ============================================= #
  # Literal Handling
  # ============================================= #

  # Function desc: Checks if current character is a numeric value
  def is_digit(c)
    return c >= '0' && c <= '9'
  end

  # Function desc: Checks if current character is a alphabetical value or '_'
  def is_alpha(c)
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c == '_')
  end

  # Function desc: Checks if current character is a alphabetical or numeric value
  def is_alpha_numeric(c)
    return is_alpha(c) || is_digit(c)
  end

  # Function desc: Creates a string literal token
  def make_string_literal
    while (peek != '"' && !is_at_end)
      if (peek == '\n')
        @line_pos += 1
        @col_pos = 0
      end
      advance_pos
    end

    if is_at_end
      @lox.error(@line_pos, @col_pos, "Undetermined string.")
    end

    advance_pos

    value = @src[@start_pos + 1, @col_pos - 2]

    add_token(TOKEN_TYPE::STRING, value)
  end

  # Function desc: Creates a number literal token
  def make_number_literal
    while(is_digit(peek))
      advance_pos
    end

    if (peek == '.' && is_digit(peek_next))
      advance_pos

      while (is_digit(peek))
        advance_pos
      end
    end

    add_token(TOKEN_TYPE::NUMBER, @src[@start_pos, @next_pos -1].to_f)
  end

  # Function desc: Creates either an identifier or keyword token
  def make_identifier
    while(is_alpha_numeric(peek))
      advance_pos
    end

    text = src_substring(@start_pos, @next_pos)

    type = string_to_type(text)


    add_token(type)
  end


  # ============================================= #
  # Token Handling
  # ============================================= #


  # Function desc: Adds given token type to token_list
  # Note: Has two versions based on amount of arguments given
  def add_token(* args)
    text = src_substring(@start_pos, @next_pos)

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
      @line_pos += 1
      @col_pos = 0
    when '"'
      make_string_literal
    else
      if is_digit(c)
        make_number_literal
      elsif is_alpha(c)
        make_identifier
      else
        @lox.error(@line_pos, @col_pos, "Unexpected character")
      end

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