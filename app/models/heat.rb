class Heat < ApplicationRecord
  validates :number, presence: true, uniqueness: { scope: :datalist_id }
  validates :car_id, presence: true

  belongs_to :datalist
  belongs_to :car
  belongs_to :circuit
  belongs_to :user
  has_many :laptimes, dependent: :destroy
  has_many :settings, dependent: :destroy

  accepts_nested_attributes_for :laptimes, allow_destroy: true
  accepts_nested_attributes_for :settings, allow_destroy: true
end
