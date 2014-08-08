class Appointment
  attr_accessor :doctor, :patient, :date, :cost

  def initialize(attributes)
    @doctor = attributes[:doctor]
    @patient = attributes[:patient]
    @date = attributes[:date]
  end

end
