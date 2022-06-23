class RemoveDateFromPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :date
  end
end
