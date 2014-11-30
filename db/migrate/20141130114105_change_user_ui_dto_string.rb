class ChangeUserUiDtoString < ActiveRecord::Migration
  def change
    change_column :users, :uid, :text
  end
end
