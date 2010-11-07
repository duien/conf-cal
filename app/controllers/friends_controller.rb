class FriendsController < ApplicationController
  def index
    @friends = current_user.friends

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
