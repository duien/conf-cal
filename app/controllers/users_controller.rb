class UsersController < ApplicationController
  def show
    @user = User.find params[:id]

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
