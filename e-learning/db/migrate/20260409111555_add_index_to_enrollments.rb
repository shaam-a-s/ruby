class AddIndexToEnrollments < ActiveRecord::Migration[7.0]
  def change
    add_index :enrollments, [:student_id, :course_id], unique: true
  end
end