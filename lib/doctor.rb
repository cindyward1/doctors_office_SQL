class Doctor

  attr_accessor :name, :specialty, :insurance

  def initialize(attributes)
    @name = attributes[:name]
  end

  def specialty_add(specialty)
    @specialty = specialty
  end

  def insurance_add(insurance)
    @insurance = insurance
  end

end
