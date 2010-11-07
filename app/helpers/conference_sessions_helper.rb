module ConferenceSessionsHelper
  def time_link( time, text )
    link_to( text, conference_sessions_by_date_time_path( time.strftime('%Y-%m-%d'), time.strftime('%H:%M') ))
  end

  def format_time( conference_session, options = {} )
    "#{options[:include_day] ? "#{conference_session.start_time.strftime('%A')} " : '' }#{conference_session.start_time.strftime('%I:%M %p')} - #{conference_session.end_time.strftime('%I:%M %p')}"
  end

  def friends_text( conference_session )
    # you and 3 friends going
    # you, 2 friends, and 5 others going
    # you and 5 others going
    # you're going
    # 1 friend and 5 others going
    # 4 people going
    # 2 friends going

    attending = conference_session.attendees.include? current_user
    total_attendees = conference_session.attendees.length
    friends_attending = current_user.friends.attending(conference_session).length
    non_friends_attending = total_attendees - friends_attending
    non_friends_attending -= 1 if attending

    if total_attendees > 0
      text = []
      if attending and total_attendees == 1
        text << "you're"
      elsif attending
        text << "you"
      end

      if friends_attending > 0
        text << pluralize(friends_attending, "friend")
      end

      if non_friends_attending > 0
        other_word = attending || friends_attending > 0 ? 'other' : 'person'
        text << pluralize(non_friends_attending, other_word)
      end
      text.to_sentence + " going"
    end
  end
end
