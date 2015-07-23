class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.integer :http_res
      t.integer :website_id

      t.timestamps null: false
    end
  end
end
