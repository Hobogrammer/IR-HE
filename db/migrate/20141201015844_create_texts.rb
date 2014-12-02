class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :title
      t.text :content
      t.text :lang
      t.boolean :shared

      t.timestamps
    end
  end
end
