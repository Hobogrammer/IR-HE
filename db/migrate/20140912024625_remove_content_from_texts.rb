class RemoveContentFromTexts < ActiveRecord::Migration
  def change
    remove_column :texts, :content
  end
end
