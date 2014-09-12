class AddUserIdAndTextIdToParagraph < ActiveRecord::Migration
  def change
    add_column :paragraphs, :user_id, :integer, :null => false
    add_column :paragraphs, :text_id, :integer, :null => false
  end
end
