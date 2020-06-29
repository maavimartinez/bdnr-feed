# frozen_string_literal: true

class Repository < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
end
  

