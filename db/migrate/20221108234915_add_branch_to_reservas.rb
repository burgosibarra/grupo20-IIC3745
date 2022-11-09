# frozen_string_literal: true

class AddBranchToReservas < ActiveRecord::Migration[7.0]
  def change
    add_column :reservas, :branch, :integer
  end
end
