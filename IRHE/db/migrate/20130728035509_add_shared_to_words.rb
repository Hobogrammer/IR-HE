class AddSharedToWords < ActiveRecord::Migration
  def change
    add_column :words, :shared, :boolean, default: false
  end
end
