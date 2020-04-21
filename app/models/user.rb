class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :ownerships
  has_many :cars, through: :ownerships
  has_many :haves, class_name: 'Have'
  has_many :have_cars, through: :haves, source: :car
  has_many :joins
  has_many :circuits, through: :joins
  has_many :partakes
  has_many :partake_circits, through: :partakes, source: :circuit
  has_many :datalists, dependent: :destroy
  has_many :events, through: :datalists


  def have(car)
    self.haves.find_or_create_by(car_id: car.id)
  end

  def unhave(car)
    have = self.haves.find_by(car_id: car.id)
    have.destroy if have
  end

  def have?(car)
    self.have_cars.include?(car)
  end

  def partake(circuit)
    self.partakes.find_or_create_by(circuit_id: circuit.id)
  end

  def unpartake(circuit)
    partake = self.partakes.find_by(circuit_id: circuit.id)
    partake.destroy if partake
  end

  def partake?(circuit)
    self.partake_circits.include?(circuit)
  end

  def dataregister(event)
    self.datalists.find_or_create_by(event_id: event.id)
  end

  def undataregister(event)
    datalist = self.datalists.find_by(event_id: event.id)
    datalist.destroy if datalist
  end

  def dataregister?(event)
    self.events.include?(event)
  end

end
