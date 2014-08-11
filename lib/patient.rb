class Patient

  attr_reader :name, :birthday, :id

  def initialize(attributes)
    @name = attributes[:name]
    @birthday = attributes[:birthday]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec("SELECT id, name, TO_CHAR(birthday, 'MM/DD/YYYY') FROM patient ORDER BY id;")
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

  def self.choice(input_name)
    results = DB.exec("SELECT id, name, TO_CHAR(birthday, 'MM/DD/YYYY') FROM patient WHERE name = '#{input_name}';")
    patients = []
    results.each do |result|
      name = result['name']
      birthday = result['to_char']
      id = result['id'].to_i
      patients << Patient.new({:name => name, :birthday => birthday, :id => id})
    end
    patients
  end

  def self.choice_by_id(id)
    results = DB.exec("SELECT id, name, TO_CHAR(birthday, 'MM/DD/YYYY') FROM patient WHERE id = #{id};")
    patients = []
    results.each do |result|
      name = result['name']
      birthday = result['to_char']
      id = result['id'].to_i
      patients << Patient.new({:name => name, :birthday => birthday, :id => id})
    end
    patients
  end

  def delete
    DB.exec("DELETE FROM patient WHERE id = '#{self.id}';")
  end

  def update_birthday(birthday)
    DB.exec("UPDATE patient SET birthday = TO_DATE('#{birthday}', 'MM/DD/YYYY') WHERE id = '#{self.id}';")
  end

  def update_name(name)
    DB.exec("UPDATE patient SET name = '#{name}' WHERE id = #{self.id};")
  end

end
