require "spec_helper"

describe Patient do

  it "is initialized with a name and a birthdate" do
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthdate=>"08/01/1983"})
    expect(test_patient).to be_an_instance_of Patient
  end

  it "tells you his/her name" do
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    expect(test_patient.name).to eq "Kim Kardashian"
    expect(test_patient.birthday).to eq "08/01/1983"
  end

  it "starts with an empty array" do
    expect(Patient.all).to eq []
  end

  it "saves an insurance company to the empty array" do
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983", :id=>1})
    test_patient.save
    expect(Patient.all).to eq [test_patient]
  end

end
