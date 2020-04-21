class Car < ApplicationRecord
  mount_uploader :img, ImageUploader

  has_many :heats, dependent: :destroy
  has_many :ownerships, dependent: :destroy
  has_many :users, through: :ownerships

  has_many :haves, class_name: 'Have'
  has_many :havings_users, through: :haves, source: :user
end
