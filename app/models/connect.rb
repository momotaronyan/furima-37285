class Connect < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true
  validates :comment, presence: true
end
