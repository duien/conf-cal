module ApplicationHelper

  def sessions_by_timeslot (sessions)
    sessions = sessions.group_by { |p| p.start_time.strftime('%A') }
    sessions.inject({}) do |result, (day, session_list)|
      result.update(day => session_list.group_by(&:start_time))
    end
  end

  def current_if_controller( controller_name )
    controller_name == controller.controller_name ? 'current' : nil
  end

  def display_name (user)
    raw "#{link_to user.name, user_url(user)} (<a href='http://twitter.com/#{user.login}'>@#{user.login}</a>)"
  end

end
