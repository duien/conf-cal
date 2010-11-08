module ConferenceSessionsHelper
  def time_link( time, text )
    link_to( text, conference_sessions_by_date_time_path( time.strftime('%Y-%m-%d'), time.strftime('%H:%M') ))
  end

  def format_time( conference_session, options = {} )
    "#{options[:include_day] ? "#{conference_session.start_time.strftime('%A')} " : '' }#{conference_session.start_time.strftime('%I:%M %p')} - #{conference_session.end_time.strftime('%I:%M %p')}"
  end

  def friends_text( conference_session, options = {} )
    unless current_user
      total_attendees = conference_session.attendees.length
      return total_attendees > 0 ? "#{pluralize(total_attendees, 'person')} going" : ''
    end

    friends = current_user.friends
    friends_attending = (conference_session.attendees & friends).length

    attending = conference_session.attendees.include? current_user
    total_attendees = conference_session.attendees.length
    non_friends_attending = total_attendees - friends_attending
    non_friends_attending -= 1 if attending

    text = []
    unless options[:hide_self]
      if attending and total_attendees == 1
        text << "you're"
      elsif attending
        text << "you"
      end
    end

    if friends_attending > 0
      text << pluralize(friends_attending, "friend")
    end

    if non_friends_attending > 0
      other_word = attending || friends_attending > 0 ? 'other' : 'person'
      text << pluralize(non_friends_attending, other_word)
    end
    text.to_sentence + " going" unless text.empty?
  end

  def friend_list( conference_session )
    unless current_user
      total_attendees = conference_session.attendees.length
      return total_attendees > 0 ? [pluralize(total_attendees, 'person')] : []
    end

    attending = conference_session.attendees.include? current_user
    total_attendees = conference_session.attendees.length
    friends_attending = current_user.friends.attending(conference_session) || []
    non_friends_attending = total_attendees - friends_attending.length
    non_friends_attending -= 1 if attending
    
    friends = friends_attending.collect{ |f| display_name(f) }
    if friends.length > 0
      friends << "... and #{pluralize(non_friends_attending, 'other')}" if non_friends_attending > 0
    else
      friends << pluralize(non_friends_attending, 'person')
    end
    friends

  end
end
