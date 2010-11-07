class User < TwitterAuth::GenericUser

  has_many :attendances
  has_many :conference_sessions, :through => :attendances
  has_many :friendships
  has_many :friends, :through => :friendships

  scope :attending, lambda { |cs| joins(:attendances).where(:attendances => {:conference_session_id => cs.id}) }

  FRIEND_CACHE_DURATION = 10.minutes

  # Update cached friends if the cache has timed out
  def after_find
    if last_updated_friends.nil? or (Time.now - last_updated_friends > FRIEND_CACHE_DURATION)
      last_updated_friends = Time.now
      self.save!
      begin
        friends = User.find( :conditions => {:twitter_id => self.twitter.get('/friends/ids.json')} )
      rescue Exception => e
        logger.error "Could not fetch friends for user #{self.id} from twitter: #{e}"
      end
    end
  end

end
