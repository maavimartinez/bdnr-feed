# frozen_string_literal: true

class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
