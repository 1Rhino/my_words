class IndexWord < ActiveRecord::Migration
  def change
    add_index :words, :word, :name => 'word', :type => :unique
    add_index :words, :view_counter, :name => 'view_counter'
  end
end
