class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :url
      t.string :ogtype
      t.string :title
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
