class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]

  def index
    @courses = Course.includes(:lessons).order(:name)
  end

  def show
    @lessons = @course.lessons.order(:name)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: "Course created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: "Course deleted successfully."
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :instructor)
  end
end
