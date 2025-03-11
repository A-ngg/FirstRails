class UsersController < ApplicationController
    before_action :authenticate_user! # Ensure user is logged in

    def profile
      @posts = current_user.posts # Fetch only the logged-in user's posts
    end
end
