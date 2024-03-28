# FILE: stmt.rb
# CLASS: Stmt
# PURPOSE: Manages and represent statements
# AUTHOR(S): Isaiah Parker


# Class desc: Manages and represent statements
class Stmt


  # ============================================= #
  # Statement Types
  # ============================================= #

  class Print < Stmt

    # Simple Accessor Methods
    attr_reader :expression

    def initialize(expr)
      @expression = expr
    end

    # Function desc: calls corresponding visit method and passes itself into it
    def accept(visitor)
      visitor.visit_print_stmt(self)
    end


  end

  class Expression < Stmt

    # Simple Accessor Methods
    attr_reader :expression

    def initialize(expr)
      @expression = expr
    end

    # Function desc: calls corresponding visit method and passes itself into it
    def accept(visitor)
      visitor.visit_print_stmt(self)
    end

  end

end