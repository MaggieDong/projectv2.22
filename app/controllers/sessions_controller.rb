class SessionsController < ApplicationController
  def new
  end

  def create
    user=Developer.find_by(email: params[:session][:email].downcase) if params[:loginas]== '1'
    user=Admin.find_by(email: params[:session][:email].downcase) if params[:loginas]== '2'
    if user && user.password==params[:session][:password]
      log_in user
      redirect_to user
    else
      flash[:notice]='Invalid email/password combination, please try later'
  #    render 'new'
      redirect_to login_path
    end
  end

  def logout
    log_out
    redirect_to root_path
  end
end
