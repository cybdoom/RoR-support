module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
  end

  protected

  def generate_token
    self.token = loop do
      random_str = SecureRandom.base64 3
      random_token = "#{ random_str }-#{ SecureRandom.hex 2 }-#{ random_str }-#{ SecureRandom.hex 2 }-#{ random_str }"
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
