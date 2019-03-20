class CreateHotlineServices < ActiveRecord::Migration[5.2]
  def change
    create_table :hotline_services do |t|
      t.string :href
      t.bigint :category_id
      t.string :value

      t.timestamps
    end
  end
end
