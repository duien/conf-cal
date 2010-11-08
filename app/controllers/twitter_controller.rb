class TwitterController < ApplicationController
  def post
    text = params['text']
    current_user.twitter.post('/statuses/update.json', 'status' => text)
    redirect_to '/friends'
  end
end
