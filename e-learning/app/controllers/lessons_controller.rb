class LessonsController < ApplicationController
  before_action :set_lesson, only: [ :show, :edit, :update, :destroy ]
  before_action :set_courses, only: [ :new, :create, :edit, :update ]

  def index
    @lessons = Lesson.includes(:course).order(:name)
  end

  def show
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      redirect_to @lesson, notice: "Lesson created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to @lesson, notice: "Lesson updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
    redirect_to lessons_path, notice: "Lesson deleted successfully."
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_courses
    @courses = Course.order(:name)
  end

  def lesson_params
    params.require(:lesson).permit(:name, :description, :course_id)
  end
end
