class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  def index
    @tweets = Tweet.all
  end
  def show
    @tweet = Tweet.friendly.find(params[:id])
    @comments=@tweet.comments
  end
  def new
    @tweet = current_user.tweets.build
  end
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to @tweet, notice: "Tweet was successfully created."
    else
      render :new
    end
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: "Tweet was successfully updated."
    else
      render :edit
    end
  end
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_url, notice: "Tweet was successfully destroyed."
  end
  private
  def tweet_params
    params.require(:tweet).permit(:content, :category_id)
  end
end
