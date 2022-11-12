# frozen_string_literal: true

class AddAgeToReservas < ActiveRecord::Migration[7.0]
  def change
    add_column :reservas, :age, :integer
  end
end
