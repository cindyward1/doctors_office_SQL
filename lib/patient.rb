class Patient
  attr_accessor :name, :birthday, :id

  def initialize(attributes)
    @name = attributes[:name]
    @birthday = attributes[:birthday]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec("SELECT id, name, TO_CHAR(birthday, 'MM/DD/YYYY') FROM patient;")
    patients = []
    results.each do |result|
      name = result['name']
      birthday = result['to_char']
      id = result['id'].to_i
      patients << Patient.new({:name => name, :birthday => birthday, :id => id})
    end
    patients
  end

  def save
    patient = DB.exec("INSERT INTO patient (name, birthday) " +
      "VALUES ('#{@name}', TO_DATE('#{@birthday}', 'MM/DD/YYYY')) RETURNING id;")
    @id = patient.first['id'].to_i
  end

  def ==(another_patient)
    self.name == another_patient.name && self.birthday == another_patient.birthday
  end
end
