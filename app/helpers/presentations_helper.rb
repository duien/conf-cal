module PresentationsHelper
  def time_link( time, text )
    link_to( text, presentations_by_date_time_path( time.strftime('%Y-%m-%d'), time.strftime('%H:%M') ))
  end

  def format_time( presentation )
    "#{presentation.start_time.strftime('%I:%M %p')} - #{presentation.end_time.strftime('%I:%M %p')}"
  end
end
