class CreateDiscounts < ActiveRecord::Migration[8.1]
  def change
    create_table :discounts do |t|
      t.string :code
      t.integer :percentage
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
