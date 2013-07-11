class Create < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.string :tz
      t.boolean :admin , default: false

      t.timestamps
    end
  end
end
