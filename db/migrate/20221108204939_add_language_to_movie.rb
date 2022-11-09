# frozen_string_literal: true

class AddLanguageToMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :language, :integer, null: false
  end
end
