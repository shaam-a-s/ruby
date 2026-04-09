class EnrollmentsController < ApplicationController
  def create
    student = Student.find(params[:student_id])
    course = Course.find(params[:course_id])
    enrollment = Enrollment.new(student: student, course: course)

    if enrollment.save
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "Enrollment successful." }
        format.json { render json: { message: "Enrollment successful" }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to dashboard_path, alert: "Enrollment failed: #{enrollment.errors.full_messages.to_sentence}" }
        format.json do
          render json: {
            message: "Enrollment failed",
            errors: enrollment.errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end
rescue ActiveRecord::RecordNotFound
  respond_to do |format|
    format.html { redirect_to dashboard_path, alert: "Enrollment failed: student or course not found." }
    format.json { render json: { message: "Enrollment failed", errors: [ "Student or course not found" ] }, status: :not_found }
  end
end
