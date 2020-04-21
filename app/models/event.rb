class Event < ApplicationRecord
  validates :day, presence: true, uniqueness: { scope: :circuit_id }

  belongs_to :circuit
  has_many :datalists, dependent: :destroy
  has_many :users, through: :datalists
end
