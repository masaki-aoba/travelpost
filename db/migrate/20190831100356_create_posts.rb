class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :sightseeing
      t.string :country
      t.string :content
      t.integer :evaluation
      t.string :image_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
