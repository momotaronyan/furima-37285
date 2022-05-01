class CreateConnects < ActiveRecord::Migration[6.0]
  def change
    create_table :connects do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :content, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
