# FILE: token.rb
# CLASS: Token
# PURPOSE: Represents the smallest lexical unit in the Lox language
# AUTHOR(S): Isaiah Parker


# Define token types
module TOKEN_TYPE
  # Single Character
  LEFT_PAREN = 0
  RIGHT_PAREN = 1
  LEFT_BRACE = 2
  RIGHT_BRACE = 3
  COMMA = 4
  DOT = 5
  MINUS = 6
  PLUS = 7
  SEMICOLON = 8
  SLASH = 9
  STAR = 10

  # One or two Character
  BANG = 11
  BANG_EQUAL = 12
  EQUAL = 13
  EQUAL_EQUAL = 14
  GREATER = 15
  GREATER_EQUAL = 16
  LESS = 17
  LESS_EQUAL = 18

  # Keywords
  AND = 19
  CLASS = 20
  ELSE = 21
  FALSE = 22
  FUN = 23
  FOR = 25
  IF = 26
  NIL = 27
  OR = 28
  PRINT = 29
  RETURN = 30
  SUPER = 31
  TRUE = 32
  VAR = 33
  WHILE = 34

  # Special
  NEW_LINE = 35
  EOF = 36


end


# Class desc: Represents the smallest lexical unit in the Lox language
class Token
  def initialize(type, lexeme, literal, line)

    # ============================================= #
    # Class Variables
    # ============================================= #

    @tkn_type = type
    @tkn_lexeme = lexeme
    @tkn_literal = literal
    @tkn_line = line



    # Function desc: Maps TOKEN_TYPE constants to string equivalents
    def type_to_str(type)
      type_map =
        {
          TOKEN_TYPE::LEFT_PAREN => "LEFT_PAREN",
          TOKEN_TYPE::RIGHT_PAREN => "RIGHT_PAREN",
          TOKEN_TYPE::LEFT_BRACE => "LEFT_BRACE",
          TOKEN_TYPE::RIGHT_BRACE => "RIGHT_BRACE",
          TOKEN_TYPE::COMMA => "COMMA",
          TOKEN_TYPE::DOT => "DOT",
          TOKEN_TYPE::MINUS => "MINUS",
          TOKEN_TYPE::PLUS => "PLUS",
          TOKEN_TYPE::SEMICOLON => "SEMICOLON",
          TOKEN_TYPE::SLASH => "SLASH",
          TOKEN_TYPE::STAR => "STAR",
          TOKEN_TYPE::BANG => "BANG",
          TOKEN_TYPE::BANG_EQUAL => "BANG_EQUAL",
          TOKEN_TYPE::EQUAL => "EQUAL",
          TOKEN_TYPE::EQUAL_EQUAL => "EQUAL_EQUAL",
          TOKEN_TYPE::GREATER => "GREATER",
          TOKEN_TYPE::GREATER_EQUAL => "GREATER_EQUAL",
          TOKEN_TYPE::LESS => "LESS",
          TOKEN_TYPE::LESS_EQUAL => "LESS_EQUAL",
          TOKEN_TYPE::AND => "AND",
          TOKEN_TYPE::CLASS => "CLASS",
          TOKEN_TYPE::ELSE => "ELSE",
          TOKEN_TYPE::FALSE => "FALSE",
          TOKEN_TYPE::FUN => "FUN",
          TOKEN_TYPE::FOR => "FOR",
          TOKEN_TYPE::IF => "IF",
          TOKEN_TYPE::NIL => "NIL",
          TOKEN_TYPE::OR => "OR",
          TOKEN_TYPE::PRINT => "PRINT",
          TOKEN_TYPE::RETURN => "RETURN",
          TOKEN_TYPE::SUPER => "SUPER",
          TOKEN_TYPE::TRUE => "TRUE",
          TOKEN_TYPE::VAR => "VAR",
          TOKEN_TYPE::WHILE => "WHILE",
          TOKEN_TYPE::NEW_LINE => "NEW_LINE",
          TOKEN_TYPE::EOF => "EOF"
        }
      type_map.default = "UNRECOGNIZED TOKEN"

      return type_map[type].to_s
    end


    def to_s
      # Format: (line #) [TOKEN_TYPE] (char representation) (literal)
      return "#{@tkn_line} ".ljust(6) +  ("[" + type_to_str(@tkn_type) + "]").ljust(16) +  " " + @tkn_lexeme.to_s + " " + @tkn_literal.to_s
    end

  end
end
# EOF
