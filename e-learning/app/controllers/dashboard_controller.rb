class DashboardController < ApplicationController
  def index
    @students = Student.order(:name)
    @courses = Course.includes(:lessons).order(:name)
    @lessons = Lesson.includes(:course).order(:name)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          students: @students,
          courses: @courses,
          lessons: @lessons
        }
      end
    end
  end
end
