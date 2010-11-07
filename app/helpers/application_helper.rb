module ApplicationHelper

  def sessions_by_timeslot (sessions)
    sessions = sessions.group_by { |p| p.start_time.strftime('%A') }
    sessions.inject({}) do |result, (day, session_list)|
      result.update(day => session_list.group_by(&:start_time))
    end
  end

end
