class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.references :cafe, null: false, foreign_key: true
      t.string :user_name, null: false
      t.integer :rating, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
