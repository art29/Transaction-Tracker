class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :income
      t.references :user, index: true
      t.timestamps
    end
  end
end
