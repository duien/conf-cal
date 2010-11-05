module ConferenceSessionsHelper
  def time_link( time, text )
    link_to( text, conference_sessions_by_date_time_path( time.strftime('%Y-%m-%d'), time.strftime('%H:%M') ))
  end

  def format_time( conference_session, options = {} )
    "#{options[:include_day] ? "#{conference_session.start_time.strftime('%A')} " : '' }#{conference_session.start_time.strftime('%I:%M %p')} - #{conference_session.end_time.strftime('%I:%M %p')}"
  end
end
