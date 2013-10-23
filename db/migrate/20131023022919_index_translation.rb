class IndexTranslation < ActiveRecord::Migration
  def change
    add_index :translations, :translation, :name => 'translation'
    add_index :translations, :like_counter, :name => 'like_counter'
  end
end
