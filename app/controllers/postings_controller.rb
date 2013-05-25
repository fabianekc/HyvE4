class PostingsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @posting = current_user.postings.build(params[:posting])
    if @posting.save
      flash[:success] = "Posting published!"
      redirect_to root_url
    else
      @feed_items = []
      render 'users/new'
    end
  end

  def destroy
    @posting.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @posting = current_user.postings.find_by_id(params[:id])
      redirect_to root_url if @posting.nil?
    end

end
