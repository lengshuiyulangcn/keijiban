class AddAuthToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :auth, :integer
  end
end
