class Datalist < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :heats, dependent: :destroy
end
