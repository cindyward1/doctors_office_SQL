class Specialty

  attr_reader :name, :id

  def initialize (attributes)
    @name = attributes[:name]
    @id = attributes[:id]
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

  def self.choice(input_name)
    results = DB.exec("SELECT * FROM specialty WHERE name = '#{input_name}';")
    specialties = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      specialties << Specialty.new({:name=>name, :id=>id})
    end
    specialties
  end

    def self.choice_by_id(id)
    results = DB.exec("SELECT id, name FROM specialty WHERE id = #{id};")
    specialty = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      specialty << Specialty.new({:name => name, :id => id})
    end
    specialty
  end

  def delete
    DB.exec("DELETE FROM specialty WHERE id = #{self.id};")
  end

  def update_name(input_name)
    DB.exec("UPDATE specialty SET name = '#{input_name}' WHERE id = #{self.id};")
  end

end
