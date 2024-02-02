module TOKEN_TYPE
  # Single Character
  LEFTPARN = 0
  RIGHTPARN = 1



end



class Token
  def initialize(type, name)
    @tkn_type = type
    @tkn_name = name
  end



end
