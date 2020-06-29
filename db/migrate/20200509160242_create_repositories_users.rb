# frozen_string_literal: true

class CreateRepositoriesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories_users do |t|
      t.references :user, foreign_key: true
      t.references :repository, foreign_key: true
      t.boolean :is_creator

      t.timestamps
    end
  end
end
