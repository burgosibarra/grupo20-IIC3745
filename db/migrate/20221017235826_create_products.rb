# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.bigint :price, null: false
      t.integer :category, null: false
      t.float :size

      t.timestamps
    end
  end
end
