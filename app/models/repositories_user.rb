# frozen_string_literal: true

class RepositoriesUser < ApplicationRecord
    belongs_to :user
    belongs_to :repository
end
  