module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
  end

  protected

  def generate_token
    self.token = loop do
      random_str = SecureRandom.base64 3
      random_token = "#{ SecureRandom.hex 3 }-#{ SecureRandom.hex 2 }-#{ SecureRandom.hex 3 }-#{ SecureRandom.hex 2 }-#{ SecureRandom.hex 3 }"
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
