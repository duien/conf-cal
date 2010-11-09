class User < TwitterAuth::GenericUser

  has_many :attendances
  has_many :conference_sessions, :through => :attendances
  has_many :friendships
  has_many :friends, :through => :friendships

  scope :attending, lambda { |cs| joins(:attendances).where(:attendances => {:conference_session_id => cs.id}) }

  FRIEND_CACHE_DURATION = 30.minutes

  # Override friends to check the cache and update from Twitter as necessary.
  #
  alias :orig_friends :friends
  def friends
    if self.last_updated_friends.nil? or (Time.now - self.last_updated_friends > FRIEND_CACHE_DURATION)
      self.last_updated_friends = Time.now
      self.save!
      self.update_friends
    end
    orig_friends
  end

  # Fetch this user's friends from Twitter and set up Friendships as
  # appropriate.  Returns true if succesful, false otherwise.
  #
  def update_friends
    begin
      self.last_updated_friends = Time.now
      self.save!
      self.friends = User.find( :all, :conditions => {:twitter_id => self.twitter.get('/friends/ids.json').map(&:to_s)} )
      return true
    rescue Exception => e
      logger.error "Could not fetch friends for user #{self.id} from twitter: #{e}"
      return false
    end
  end

  handle_asynchronously :update_friends
end
