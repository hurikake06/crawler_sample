class CreateHotlineCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :hotline_categories do |t|
      t.string :href
      t.string :name
      t.bigint :parent_id

      t.timestamps
    end
  end
end
