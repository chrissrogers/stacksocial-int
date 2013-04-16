class HomeController < ApplicationController
  def index
    @term = params[:term] || 'bananas'
    @tweets = Twitter.search(@term, { count: 20 }).statuses
  end

  def user_detail
    render :json => Twitter.user_timeline(params[:id])
  end
end
