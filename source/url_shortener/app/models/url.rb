class Url < ActiveRecord::Base
  validates_presence_of :full_url
  validates_uniqueness_of :full_url
  # I've written a custom validator called 'proper_url_format'
  # checkout the method later in this class
  validate :proper_url_format

  # since all new Urls will need a short code,
  # I'm calling the method that sets the short_code 
  # before creating a new Url record. This runs before
  # the new Url record is saved.
  #
  # If you're unfamilar with the before_* and after_*
  # hooks, see http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
  before_create :set_short_code

  SHORT_CODE_LENGTH = 8

  def self.generate_short_code
    (0...SHORT_CODE_LENGTH).map { (65 + rand(26)).chr }.join
  end

  def set_short_code
    self.short_code = Url.generate_short_code
  end

  def increment_access_count
    self.access_count += 1
    self.save
  end

  def proper_url_format
    # If the full_url property doesn't start with http://
    # add a custom error to the list of errors for this
    # instance
    #
    # The presence of any errors on an AR object will prevent
    # it from saving (e.g. url.save will return false)
    if self.full_url.index("http://") != 0
      self.errors.add(:full_url,
                      "must begin with http://")
    end
  end
end
