class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :translation, null: false
      t.integer :like_counter, default: 0
      t.belongs_to :word

      t.timestamps
    end
  end
end
