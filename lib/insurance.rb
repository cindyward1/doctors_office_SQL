class Insurance

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec("SELECT * FROM insurance;")
    insurances = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      insurances << Insurance.new({:name=>name, :id=>id})
    end
    insurances
  end

  def save
    insurance = DB.exec("INSERT INTO insurance (name) VALUES ('#{@name}') RETURNING id;")
    @id = insurance.first['id'].to_i
  end

  def ==(another_insurance)
    self.name == another_insurance.name
  end

  def self.choice(input_name)
    results = DB.exec("SELECT * FROM insurance WHERE name = '#{input_name}';")
    insurances = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      insurances << Insurance.new({:name=>name, :id=>id})
    end
    insurances
  end

  def self.choice_by_id(id)
    results = DB.exec("SELECT * FROM insurance WHERE id = #{id};")
    insurances = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      insurances << Insurance.new({:name => name, :id => id})
    end
    insurances
  end

  def delete
    DB.exec("DELETE FROM insurance WHERE id = #{self.id};")
  end

  def update_name(input_name)
    DB.exec("UPDATE insurance SET name = '#{input_name}' WHERE id = #{self.id};")
  end

end
