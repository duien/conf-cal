namespace :ical do
  task :import, [:conference_name] => :environment do |t, args|
    raise "Conference name required" unless args[:conference_name].present?
    conference = Conference.find_or_create_by_name(args[:conference_name])

    cal_url = 'http://www.rubyconf.org/schedule.ics'
    require 'open-uri'

    cal_stream = open(cal_url)
    cals = RiCal.parse(cal_stream)
    cal = cals.first
    cal.events.each do |event|
      summary = event.summary.strip
      presentation = ConferenceSession.find_or_create_by_summary_and_conference_id(summary, conference.id)
      presentation.update_attributes(
        :uid => event.uid,
        :description => event.description,
        :location => event.location,
        :start_time => event.start_time,
        :end_time => event.finish_time
      )
    end

    presentations_url = 'http://rubyconf.org/presentations'
    require 'hpricot'
    require 'cgi'

    presentations_stream = open(presentations_url)
    parsed = Hpricot(presentations_stream)
    table = parsed.at('table')
    table.search('tr').each do |row|
      presentation_data = row.search('td').map{ |td| CGI.unescapeHTML td.inner_html.strip }
      next if presentation_data.empty? or presentation_data.all?{ |d| d.blank? }
      presentation = ConferenceSession.find_by_summary_and_conference_id(presentation_data[1], conference.id)
      presentation.update_attribute(:presenters, presentation_data[2]) if presentation
    end
  end
end
      
