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
  EOF = 35
end


class Token
  def initialize(type, lexeme, literal, line)
    @tkn_type = type
    @tkn_lexeme = lexeme
    @tkn_literal = literal
    @tkn_line = line

    def to_s
      return @tkn_type.to_s + " " + @tkn_lexeme.to_s + " " + @tkn_literal.to_s
    end


  end



end
