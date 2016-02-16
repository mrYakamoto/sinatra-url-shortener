class Url < ActiveRecord::Base
  before_save :shorten_url

  # validates_uniqueness_of :short_url

  def shorten_url
    self.short_url = SecureRandom.urlsafe_base64[0..5]
  end

end


# url = Url.create!(url: sdjf)
# url = Url.new(url: sdjf)
# url.save! #false
# url.errors.full_messages
