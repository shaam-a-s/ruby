class CreateResumes < ActiveRecord::Migration[8.1]
  def change
    create_table :resumes do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :summary
      t.text :education
      t.text :skills

      t.timestamps
    end
  end
end
