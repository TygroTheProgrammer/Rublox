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
    # String representation of program
    @src = src_string

    # The Interpreter Object
    @lox = lox

    # Contains all scanned tokens
    @token_list = []

    # Index Pointers
    @start_pos = 0 # Tracks the index of the first character in the token
    @next_pos = 0 # Tracks the position of subsequent characters after the start


    # Trackers
    @line_pos = 1 # Tracks which line the scanners "eye" is
    @col_pos = 0 # Tracks which column the scanners "eye" is

    # Flags
    @end_of_file = false
    @end_of_line = false

  end

  # ============================================= #
  # Helper Functions
  # ============================================= #

  # Function desc: Simple boolean method that checks if the char pointer is at the end of the program
  def is_at_end
    (@next_pos >= @src.length) # return
  end

  # Function desc: Moves char pointer to next position
  def advance_pos
    # Update index pointers
    @next_pos += 1
    @col_pos += 1
  end

  # Function desc: Returns current char and moves char pointer to next position
  def grab_advance

    # Stores the character at current position
    current_char = @src[@next_pos]

    # Advance forward
    advance_pos

    current_char # return
  end

  # Function desc: Acts as a conditional advance function
  def match(expected)
    # Handles EOF edge case
    if is_at_end
      return false
    end

    # If it is not the expected return false and exit out
    if @src[@next_pos] != expected
      return false
    end

    # If true advance
    advance_pos
    true # return
  end

  # Function desc: Returns the next character without consuming it
  def peek
    if is_at_end
      # Return null
      return "\0"
    end
    @src[@next_pos] # return
  end

  # Function desc: Returns the character after the next character without consuming it
  def peek_next
    if @next_pos + 1 >= @src.length
      # Return null
      return "\0"
    end
    @src[@next_pos + 1] # return
  end

  # Function Desc: Maps string keywords to their respective token types
  def string_to_type(string)
    keyword_map =
      {
        "and" => :and,
        "class" => :class,
        "else" => :else,
        "false" => :false,
        "for" => :for,
        "fun" => :fun,
        "if" => :if,
        "nil" => :nil,
        "or" => :or,
        "print" => :print,
        "return" => :return,
        "super" => :super,
        "this" => :this,
        "true" => :true,
        "var" => :var,
        "while" => :while
      }
    keyword_map.default = :identifier

    keyword_map[string] # return
  end


  # Function desc: Returns a portion of the source code string
  def src_substring(start, finish)
    text = ""
    (start..(finish - 1)).each { |c|
      text += @src[c].to_s
    }
    text # return
  end


  # ============================================= #
  # Literal Handling
  # ============================================= #

  # Function desc: Checks if current character is a numeric value
  def is_digit(c)
    c >= '0' && c <= '9' # return
  end

  # Function desc: Checks if current character is a alphabetical value or '_'
  def is_alpha(c)
    (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c == '_') # return
  end

  # Function desc: Checks if current character is a alphabetical or numeric value
  def is_alpha_numeric(c)
    is_alpha(c) || is_digit(c) # return
  end

  # Function desc: Creates a string literal token
  def make_string_literal

    # Advances until hitting a '"'
    while peek != '"' && !is_at_end
      if peek == '\n'
        @line_pos += 1
        @col_pos = 0
      end
      advance_pos
    end

    # Handles string without an ending '"'
    if is_at_end
      @lox.error(@token_list[@next_pos], "Undetermined string.")
    end

    # Consumes the ending '"'
    advance_pos

    # Returns the strings value insides of the '"'s
    value = src_substring(@start_pos + 1, @next_pos -1)

    add_token(:string, value)
  end

  # Function desc: Creates a number literal token
  def make_number_literal


    while is_digit(peek)
      advance_pos
    end

    # Handles decimal numbers
    if peek == '.' && is_digit(peek_next)
      advance_pos

      while is_digit(peek)
        advance_pos
      end
    end

    # Handles numbers not at the start of the src
    if @start_pos != 0
      add_token(:number, @src[@start_pos, @next_pos -1].to_f)
    else
      # Handles if the number is at the start of the src
      add_token(:number, @src[0, @next_pos].to_f)
    end

  end

  # Function desc: Creates either an identifier or keyword token
  def make_identifier
    while is_alpha_numeric(peek)
      advance_pos
    end

    text = src_substring(@start_pos, @next_pos)

    # Determines what type of token was found
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
    else
      # Do nothing
    end
  end


  # Function desc: Assigns each detected token a type, an adds them to the list
  def scan_token
    c = grab_advance
    case c
    when '('
      add_token(:left_paren)
    when ')'
      add_token(:right_paren)
    when '{'
      add_token(:left_brace)
    when '}'
      add_token(:right_brace)
    when ','
      add_token(:comma)
    when '.'
      add_token(:dot)
    when '-'
      add_token(:minus)
    when '+'
      add_token(:plus)
    when ';'
      add_token(:semicolon)
    when '*'
      add_token(:star)
    when '!'
      add_token(match('=') ? :bang_equal : :bang)
    when '='
      add_token(match('=') ? :equal_equal : :equal)
    when '<'
      add_token(match('=') ? :less_equal : :less)
    when '>'
      add_token(match('=') ? :greater_equal : :greater)
    when '/'
      if match('/')
        # Consumes every character on line with comment
        while peek != "\n" && !is_at_end
          advance_pos
        end
      else
        add_token(:slash)
      end
    when ' ',"\r","\t"
      # Consumes these chars
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
        @lox.error(@token_list[@next_pos -1], "Unexpected character")
      end

    end


  end

  # Function desc: Scans all tokens in given program
  def scan_all_tokens
    until is_at_end
      @start_pos = @next_pos
      scan_token
    end
    @token_list.append(Token.new(:eof, "", nil, @line_pos, @col_pos))

    @token_list # return

  end

end

# EOF
