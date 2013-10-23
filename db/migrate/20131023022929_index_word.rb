class IndexWord < ActiveRecord::Migration
  def change
    add_index :words, :word, :name => 'word', :type => :unique
    add_index :words, :view_counter, :name => 'view_counter'
    add_index :words, :translation, :name => 'translation'
  end
end
