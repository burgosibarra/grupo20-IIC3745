# frozen_string_literal: true

class AddBranchToMovietime < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_times, :branch, :integer
  end
end
