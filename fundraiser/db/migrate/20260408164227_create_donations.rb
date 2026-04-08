class CreateDonations < ActiveRecord::Migration[8.1]
  def change
    create_table :donations do |t|
      t.integer :amount
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
