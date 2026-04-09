module Api
  class StudentsController < ApplicationController

    def index
      render json: Student.all
    end

    def create
      student = Student.new(student_params)
      if student.save
        render json: student, status: :created
      else
        render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def student_params
      params.require(:student).permit(:name, :email, :course, :year_of_study)
    end
  end
end