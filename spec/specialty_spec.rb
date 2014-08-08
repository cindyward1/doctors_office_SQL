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
end
