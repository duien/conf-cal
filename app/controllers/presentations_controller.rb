class PresentationsController < ApplicationController
  before_filter :login_required, :only => :index

  def index
    if params[:date] and params[:time]
      time = DateTime.parse("#{params[:date]} #{params[:time]}")
      presentations = Presentation.all( #:conditions => { :start_time => time } )
        :conditions => ["datetime(start_time) = datetime(?)", time] )
    else
      presentations = Presentation.all
    end
    presentations = presentations.group_by { |p| p.start_time.strftime('%A') }
    @presentations = presentations.inject({}) do |result, (day, pres_list)|
      result.update(day => pres_list.group_by(&:start_time))
    end
      
      # day_presentations.group_by!(&:start_time)
    puts @presentations.inspect
  end

  def show
    @presentation = Presentation.find(params[:id])
  end
end
