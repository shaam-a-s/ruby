class StudentsController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]
  before_action :set_student, only: [ :show, :edit, :update, :destroy ]

  def index
    @students = Student.order(:name)
  end

  def show
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.email = @student.email.to_s.strip.downcase

    if @student.save
      session[:student_id] = @student.id
      redirect_to dashboard_path, notice: "Student created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    attributes = student_params.to_h
    attributes["email"] = attributes["email"].to_s.strip.downcase if attributes.key?("email")

    if @student.update(attributes)
      redirect_to @student, notice: "Student updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    redirect_to students_path, notice: "Student deleted successfully."
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :email)
  end
end
