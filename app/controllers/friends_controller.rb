class FriendsController < ApplicationController
  before_filter :login_required

  def index
    @friends = current_user.friends.all( :include => :conference_sessions )

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
