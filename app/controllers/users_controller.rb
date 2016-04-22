class UsersController < ApplicationController

  # before_filter :authenticate_user!
  #helper_method :count_guesses

  #include UsersHelper

  def index

    #@users = User.all.order("points DESC")

		@users = User.find(:all, :order => "points DESC")

  end

  def count_guesses(user)
  	@number_of_guesses = Guess.find(:user => user)
  	return number_of_guesses.count()
	end
end
