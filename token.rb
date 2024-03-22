# FILE: token.rb
# CLASS: Token
# PURPOSE: Represents the smallest lexical unit in the Lox language
# AUTHOR(S): Isaiah Parker


# ============================================= #
# Define Token Types
# ============================================= #

# Single Character
:left_paren
:right_paren
:left_brace
:right_brace
:comma
:dot
:minus
:plus
:semicolon
:slash
:star

# One or two Character
:bang
:bang_equal
:equal
:equal_equal
:greater
:greater_equal
:less
:less_equal

# Keywords
:and
:class
:else
:false
:fun
:for
:if
:nil
:or
:print
:return
:super
:this
:true
:var
:while

#Literals
:string
:number
:identifier

#Special
:eof





# Class desc: Represents the smallest lexical unit in the Lox language
class Token
  # Accessor get method for each token variable
  attr_accessor :type, :lexeme, :literal, :line, :column

  def initialize(type, lexeme, literal, line, column)

    # ============================================= #
    # Class Variables
    # ============================================= #
    # The token's 'id'
    @type = type

    # The character representation of a token
    @lexeme = lexeme

    # The literal value of a token
    @literal = literal

    # Location trackers
    @line = line
    @column = column



    # Function desc: Maps TOKEN_TYPE constants to string equivalents
    def type_to_str(type)
      type_map =
        {
          left_paren: "LEFT_PAREN",
          right_paren: "RIGHT_PAREN",
          left_brace: "LEFT_BRACE",
          right_brace: "RIGHT_BRACE",
          comma: "COMMA",
          dot: "DOT",
          minus: "MINUS",
          plus: "PLUS",
          semicolon: "SEMICOLON",
          slash: "SLASH",
          star: "STAR",
          bang: "BANG",
          bang_equal: "BANG_EQUAL",
          equal: "EQUAL",
          equal_equal: "EQUAL_EQUAL",
          greater: "GREATER",
          greater_equal: "GREATER_EQUAL",
          less: "LESS",
          less_equal: "LESS_EQUAL",
          and: "AND",
          class: "CLASS",
          else: "ELSE",
          false: "FALSE",
          fun: "FUN",
          for: "FOR",
          if: "IF",
          nil: "NIL",
          or: "OR",
          print: "PRINT",
          return: "RETURN",
          super: "SUPER",
          true: "TRUE",
          var: "VAR",
          while: "WHILE",
          string: "STRING",
          number: "NUMBER",
          identifier: "IDENTIFIER",
          eof: "EOF"
        }
      type_map.default = "NULL TOKEN"

      type_map[type].to_s # return
    end

    # Function desc: Override to_s for token types
    def to_s
      # Format: [line #] [column #] [TOKEN_TYPE] (char representation) (literal)
      "[line #{@line}]".ljust(9) + " [column #{@column}] ".ljust(16) +  ("[" + type_to_str(@type)
      + "]").ljust(16) +  " " + @lexeme.to_s.ljust(16) + " " + @literal.to_s.rjust(1) # return
    end

  end
end
# EOF
