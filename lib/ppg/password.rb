class Password
  attr_accessor :password, :pattern
  attr_reader :PASSWORD_LENGTH

  def initialize (password_length, password_pattern = nil)
    raise ArgumentError, "length must be > 0" if password_length <= 0
    @PASSWORD_LENGTH = password_length.freeze
    @password = String.new
    @pattern ||= []
  end

  def length= (password_length)
    raise ArgumentError, "length must be > 0" if password_length <= 0
    @PASSWORD_LENGTH = password_length.freeze
  end

  alias :to_s :password

end
