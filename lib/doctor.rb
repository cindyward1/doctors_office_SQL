class Doctor

  attr_reader :name, :id, :specialty_id, :insurance_id, :patient_count

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @specialty_id = attributes[:specialty_id]
    @insurance_id = attributes[:insurance_id]
    @patient_count = attributes[:patient_count]
  end

  def self.all
    results = DB.exec("SELECT * FROM doctor ORDER BY id;")
    doctors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      specialty_id = result['specialty_id'].to_i
      insurance_id = result['insurance_id'].to_i
      doctors << Doctor.new({:name => name, :id => id, :specialty_id => specialty_id,
                             :insurance_id => insurance_id})
    end
    doctors
  end

  def self.choice(input_name)
    results = DB.exec("SELECT * FROM doctor WHERE name = '#{input_name}';")
    doctors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      specialty_id = result['specialty_id'].to_i
      insurance_id = result['insurance_id'].to_i
      doctors << Doctor.new({:name => name, :id => id, :specialty_id => specialty_id,
                             :insurance_id => insurance_id})
    end
    doctors
  end

  def self.choice_by_id(id)
      results = DB.exec("SELECT * FROM doctor WHERE id = #{id};")
      doctors = []
      results.each do |result|
        name = result['name']
        id = result['id'].to_i
        specialty_id = result['specialty_id'].to_i
        insurance_id = result['insurance_id'].to_i
        doctors << Doctor.new({:name => name, :id => id, :specialty_id => specialty_id,
                             :insurance_id => insurance_id})
      end
      doctors
    end

  def self.count_patient
    results = DB.exec("SELECT * FROM doctor ORDER BY name;")
    doctors = []
    results.each do |result|
      name = result['name']
      id = result['id']
      specialty_id = result['specialty_id'].to_i
      insurance_id = result['insurance_id'].to_i
      count_results = DB.exec("SELECT COUNT(p.doctor_id) AS patient_count FROM patient p WHERE doctor_id = #{id};")
      patient_count = count_results.first['patient_count']
      doctors << Doctor.new({:name => name, :id => id, :specialty_id => specialty_id,
                             :insurance_id => insurance_id, :patient_count=>patient_count})
    end
    doctors
  end

  def save
    doctor = DB.exec("INSERT INTO doctor (name, specialty_id, insurance_id) " +
      "VALUES ('#{@name}', #{@specialty_id}, #{@insurance_id}) RETURNING id;")
    @id = doctor.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def delete
    DB.exec("DELETE FROM doctor WHERE id = #{self.id};")
  end

  def update_name(input_name)
    DB.exec("UPDATE doctor SET name = '#{input_name}' WHERE id = #{self.id};")
  end

  def update_insurance(company_id)
    DB.exec("UPDATE doctor SET insurance_id = #{company_id} WHERE id = #{self.id};")
  end

  def update_specialty(specialty_id)
    DB.exec("UPDATE doctor SET specialty_id = #{specialty_id} WHERE id = #{self.id};")
  end

  def get_sum_for_doctor
    results = DB.exec("SELECT SUM(cost) as sum_for_doctor FROM appointment WHERE doctor_id = #{self.id};")
    doctor_sum = results.first['sum_for_doctor']
    doctor_sum
  end

  def get_sum_for_doctor_time(start_date, end_date)
    results = DB.exec("SELECT SUM(cost) as sum_for_doctor FROM appointment WHERE doctor_id = #{self.id} " +
                      "AND date BETWEEN TO_DATE('#{start_date}','MM/DD/YYYY') AND TO_DATE('#{end_date}', 'MM/DD/YYYY');")
    doctor_sum_time = results.first['sum_for_doctor']
    doctor_sum_time
  end

end
