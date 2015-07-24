class Password
  attr_accessor :password, :password_pattern
  attr_reader :PASSWORD_LENGTH

  def initialize (password_length, password_pattern = nil)
    raise ArgumentError, "length must be > 0" if password_length <= 0
    @PASSWORD_LENGTH = password_length.freeze
    @password = String.new
    #TODO: make password_pattern validation check method
    @password_pattern ||= []
  end

  def length= (password_length)
    raise ArgumentError, "length must be > 0" if password_length <= 0
    @PASSWORD_LENGTH = password_length.freeze
  end

  alias :to_s :password

end
