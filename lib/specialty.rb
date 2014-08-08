class Specialty

  attr_reader :name, :id

  def initialize (attributes)
    @name = attributes[:name]
  end

  def self.all
    results = DB.exec("SELECT * FROM specialty;")
    specialties = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      specialties << Specialty.new({:name=>name, :id=>id})
    end
    specialties
  end

  def save
    specialty = DB.exec("INSERT INTO specialty (name) VALUES ('#{@name}') RETURNING id;")
    @id = specialty.first['id'].to_i
  end

  def ==(another_specialty)
    self.name == another_specialty.name
  end

end
