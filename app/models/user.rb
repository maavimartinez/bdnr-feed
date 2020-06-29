# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates_format_of :name, with: /\A[a-zA-Z\s]*\Z/
  validates :surname, presence: true
  validates_format_of :surname, with: /\A[a-zA-Z\s]*\Z/
  validates :password, length: { minimum: 6, maximum: 20 }, presence: true
  validates :email, presence: true, uniqueness: true # email: true,
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
