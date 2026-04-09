class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :require_login
  helper_method :current_student, :logged_in?

  private

  def current_student
    return if session[:student_id].blank?

    @current_student ||= Student.find_by(id: session[:student_id])
  end

  def logged_in?
    current_student.present?
  end

  def require_login
    return if logged_in?

    redirect_to login_path, alert: "Please log in to continue."
  end
end
