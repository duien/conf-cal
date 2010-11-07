class FriendsController < ApplicationController
  before_filter :login_required, :only => :index

  def index
    @friends = current_user.friends

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
