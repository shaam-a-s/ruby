class SessionsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]

  def new
    return unless logged_in?

    redirect_to dashboard_path, notice: "You are already logged in."
  end

  def create
    student = Student.find_by(email: params[:email].to_s.strip.downcase)

    if student
      session[:student_id] = student.id
      redirect_to dashboard_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "No student found with that email."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Logged out successfully."
  end
end
