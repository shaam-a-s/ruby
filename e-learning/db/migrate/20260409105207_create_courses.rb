class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :instructor

      t.timestamps
    end
  end
end
