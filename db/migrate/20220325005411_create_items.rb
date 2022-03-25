class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :information, null: false
      t.integer :
      t.timestamps
    end
  end
end
