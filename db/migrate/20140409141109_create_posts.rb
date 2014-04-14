class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :tag
      t.integer :visit_count

      t.timestamps
    end
  end
end
