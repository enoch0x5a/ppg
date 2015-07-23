class Password
  attr_accessor :password, :password_pattern
  attr_reader :PASSWORD_LENGTH

  def initialize (password_length, password_pattern = nil)
    @PASSWORD_LENGTH = password_length.freeze
    @password = String.new
    #TODO: make password_pattern validation check method
    @password_pattern ||= []
  end

  def length= (length)
    @PASSWORD_LENGTH = length.freeze
  end
  
  alias :to_s :password

end
