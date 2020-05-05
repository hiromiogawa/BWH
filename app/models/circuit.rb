class Circuit < ApplicationRecord
  validates :name, presence: true
  mount_uploader :img, ImageUploader

  has_many :joins, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :users, through: :joins
  has_many :partakes, dependent: :destroy
  has_many :heats, dependent: :destroy
  has_many :partake_users, through: :partakes, source: :user
end
