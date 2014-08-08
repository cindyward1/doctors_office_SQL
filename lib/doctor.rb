class Doctor

  attr_reader :name, :id, :specialty_id, :insurance_id

  def initialize(attributes)
    @name = attributes[:name]
  end

  def specialty_add(specialty_id)
    @specialty_id = specialty_id
  end

  def insurance_add(insurance_id)
    @insurance_id = insurance_id
  end

  def self.all
    results = DB.exec("SELECT * FROM doctor;")
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

  def save
    doctor = DB.exec("INSERT INTO doctor (name, specialty_id, insurance_id) " +
      "VALUES ('#{@name}', #{@specialty_id}, #{@insurance_id}) RETURNING id;")
    @id = doctor.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end
end
