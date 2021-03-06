class UsersController < ApplicationController
	before_filter :signed_in_user, 	only: [:index, :edit, :update, :destroy]
	before_filter :registered_user,	only: [:new, :create]
	before_filter :correct_user,	only: [:edit, :update]
	before_filter :admin_user,		only: :destroy

	def show
		@user = User.find(params[:id])
		# define the microposts variable?
		@microposts = @user.microposts.paginate(page: params[:page])
	end

	def new
		@user = User.new
  	end

	def create
		@user = User.new(params[:user])
		if @user.save
			#handle a successful save
      	sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def index
#		@users = User.all
		@users = User.paginate(page: params[:page])
	end

  	def edit
  	end

	def update
	    if @user.update_attributes(params[:user])
	      	#handle a successful update.
	      	flash[:success] = "Profile updated"
	      	sign_in @user
	      	redirect_to @user
	    else
	      	render 'edit'
	    end
  	end

  	def destroy
  		user = User.find(params[:id])
  		unless current_user?(user)
  			user.destroy
	  		flash[:success] = "User destroyed."
  		else
  			flash[:error] = "Cannot delete self."
  		end
  		redirect_to users_url
  	end

  	private

  		# def signed_in_user
  		# 	unless signed_in?
  		# 		store_location
	  	# 		redirect_to signin_url, notice: "Please sign in." unless signed_in?
	  	# 	end
  		# end

  		def registered_user
  			redirect_to user_path(current_user) if signed_in?
  		end

  		def correct_user
  			@user = User.find(params[:id])
  			redirect_to(root_path) unless current_user? (@user)
  		end

  		def admin_user
  			redirect_to(root_path) unless current_user.admin?
  		end
end
