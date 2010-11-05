namespace :ical do
  task :import => :environment do
    cal_url = 'http://www.rubyconf.org/schedule.ics'
    require 'open-uri'

    cal_stream = open(cal_url)
    cals = Icalendar.parse(cal_stream)
    cal = cals.first
    cal.events.each do |event|
      presentation = Presentation.find_by_uid(event.uid) || Presentation.new
      presentation.update_attributes(
        :summary => event.summary,
        :uid => event.uid,
        :description => event.description,
        :location => event.location,
        :start_time => event.start,
        :end_time => event.end
      )
      presentation.save
    end
  end
end
      
