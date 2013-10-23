class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word, null: false
      t.integer :view_counter, default: 0

      t.timestamps
    end
  end
end
