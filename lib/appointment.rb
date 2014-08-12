class Appointment

  attr_reader :id, :doctor_id, :patient_id, :date, :cost

  def initialize(attributes)
    @doctor_id = attributes[:doctor_id]
    @patient_id = attributes[:patient_id]
    @date = attributes[:date]
    @cost = attributes[:cost]
  end

  def self.all
    results = DB.exec("SELECT id, doctor_id, patient_id, TO_CHAR(date, 'MM/DD/YYYY'), cost FROM appointment;")
    appointments = []
    results.each do |result|
      id = result['id'].to_i
      doctor_id = result['doctor_id'].to_i
      patient_id = result['patient_id'].to_i
      date = result['to_char']
      cost = result['cost'].to_i
      appointments << Appointment.new({:id=>id, :doctor_id=>doctor_id, :patient_id=>patient_id,
                                      :date=>date, :cost=>cost})
    end
    appointments
  end

  def save
    appointment = DB.exec("INSERT INTO appointment (doctor_id, patient_id, date, cost) "    +
                          "VALUES (#{@doctor_id}, #{@patient_id}, TO_DATE('#{@date}', 'MM/DD/YYYY'), #{@cost}) " +
                          "RETURNING id;")
    @id = appointment.first['id'].to_i
  end

  def ==(another_appointment)
    self.doctor_id == another_appointment.doctor_id && self.patient_id == another_appointment.patient_id &&
      self.date == another_appointment.date
  end

end
