require "spec_helper"

describe Specialty do
  it "is initialized with a name" do
    test_specialty = Specialty.new({:name => "Time travel"})
    expect(test_specialty).to be_an_instance_of Specialty
  end

  it "tells you its name" do
    test_specialty = Specialty.new({:name=>"Time travel"})
    expect(test_specialty.name).to eq "Time travel"
  end

  it "starts with an empty array" do
    expect(Specialty.all).to eq []
  end

  it "saves a specialty to the empty array" do
    test_specialty = Specialty.new({:name => "Time travel"})
    test_specialty.save
    expect(Specialty.all).to eq [test_specialty]
  end

  it "will choose and return a specialty based on the name" do
    test_specialty = Specialty.new({:name => "Time travel"})
    test_specialty.save
    expect(Specialty.choice("Time travel")).to eq [test_specialty]
  end

  it "will delete a specific specialty based on the specialty name" do
    test_specialty = Specialty.new({:name => "Time travel"})
    test_specialty.save
    return_specialty_array = Specialty.choice("Time travel")
    return_specialty_array.first.delete
    expect(Specialty.all).to eq []
  end

  it "will change the name of a specific specialty" do
    test_specialty = Specialty.new({:name => "Time travel"})
    test_specialty.save
    return_specialty_array = Specialty.choice("Time travel")
    return_specialty_array.first.update_name("Plastic surgery")
    return_specialty_array1 = Specialty.choice("Plastic surgery")
    expect(return_specialty_array1.first.name).to eq "Plastic surgery"
  end

end
