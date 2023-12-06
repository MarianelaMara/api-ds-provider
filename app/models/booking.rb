class Booking < ApplicationRecord
  include AASM
  aasm do
    state :pending, initial: true
    state :delayed
    state :finished
    state :canceled

    event :delay do
      transitions from: :pending, to: :delayed
    end
  
    event :finish do
      transitions from: [:pending, :delayed], to: :finished
    end

    event :cancel do
      transitions from: [:pending, :delayed], to: :canceled
    end
  end

  belongs_to :provider, polymorphic: true
  belongs_to :material, optional: true
  
  validates :provider_type, :provider_id, :start_date, :end_date, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates_format_of :provider_type, with: /\A(Provider|Maker)\z/
  validate :maker_availability, if: -> { provider_type == 'Maker' }
  validate :stock_availability, if: -> { provider_type == 'Provider' }
  validates_presence_of :material, if: -> { provider_type == 'Provider' }
  validates_presence_of :delivery_place, if: -> { provider_type == 'Provider' }
  before_save :assign_price
  before_save :update_stock, if: -> { provider_type == 'Provider' }

  def finish
    self.finish! if self.aasm_state == "pending" || self.aasm_state == "delayed"
  end 

  def delay
    self.delay! if self.aasm_state == "pending" 
  end 

  def cancel
    self.cancel! if self.aasm_state == "pending" || self.aasm_state == "delayed"
  end 

  def as_json(options = {})
    # Llama al método super con los mismos parámetros, pero agregando el nombre del material
    super(options.merge(methods: :material_name))
  end

  # Define un método que devuelve el nombre del material asociado a la provisión
  def material_name
    self.material.name
  end

  private

  def assign_price
    if provider_type == "Maker"
      days = (end_date - start_date).to_i + 1
      self.price = provider.price * days
    elsif provider_type == "Provider"
      material_price = Provision.find_by(provider: provider, material: material_id).price
      self.price = material_price * quantity
    end
  end

  def update_stock
    provision = Provision.find_by(provider: provider, material: material)
    provision.stock -= quantity
    provision.save
  end
  
  def maker_availability
    if Booking.where(provider_type: "Maker").where(provider: provider).where("start_date <= ? AND end_date >= ?", end_date, start_date).exists?
      errors.add(:base, "El provider ya tiene una reserva en ese rango de fechas")
    end
  end

  def stock_availability
    material_stock = Provision.find_by(provider: provider, material: material).stock
    if quantity > material_stock
      errors.add(:base, "El stock del material es insuficiente para la reserva")
    end
  end

 
  
  end