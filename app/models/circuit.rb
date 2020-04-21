class Circuit < ApplicationRecord
  mount_uploader :img, ImageUploader

  has_many :joins, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :users, through: :joins
  has_many :partakes
  has_many :partake_users, through: :partakes, source: :user
end
