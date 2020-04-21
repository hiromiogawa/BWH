class Heat < ApplicationRecord
  validates :number, presence: true, uniqueness: { scope: :datalist_id }

  belongs_to :datalist
  belongs_to :car
  has_many :laptimes, dependent: :destroy
  has_many :settings, dependent: :destroy
  belongs_to :tire

  accepts_nested_attributes_for :laptimes, allow_destroy: true
  accepts_nested_attributes_for :settings, allow_destroy: true
end
