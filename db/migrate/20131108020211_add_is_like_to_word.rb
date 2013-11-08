class AddIsLikeToWord < ActiveRecord::Migration
  def change
    add_column :words, :like, :boolean, default: false
  end
end
