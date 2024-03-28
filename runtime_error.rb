# FILE: runtime_error.rb
# CLASS: LoxRuntimeError
# PURPOSE: Handles and sends error messages
# AUTHOR(S): Isaiah Parker

class LoxRuntimeError < RuntimeError
  # Accessor get method
  attr_reader :token
  def initialize(token, message)

    super message # inherits from parent

    # ============================================= #
    # Class Variables
    # ============================================= #

    @token = token
  end
end