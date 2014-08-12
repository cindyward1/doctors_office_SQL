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

  it "saves an patient to the empty array" do
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    test_patient.save
    expect(Patient.all).to eq [test_patient]
  end

  it "will choose and return a specific patient based on the patient's name" do
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    test_patient.save
    expect(Patient.choice("Kim Kardashian")).to eq [test_patient]
  end

  it "will delete a specific patient based on the patient's name" do
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    test_patient.save
    return_patient_array = Patient.choice("Kim Kardashian")
    return_patient_array.first.delete
    expect(Patient.all).to eq []
  end

  it "will change the birthday of a specific patient based on the patient's name" do
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    test_patient.save
    return_patient_array = Patient.choice("Kim Kardashian")
    return_patient_array.first.update_birthday("10/19/1980")
    return_patient_array1 = Patient.choice("Kim Kardashian")
    expect(return_patient_array1.first.birthday).to eq "10/19/1980"
  end

  it "will change the name of a specific patient based on the patient's name" do
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    test_patient.save
    return_patient_array = Patient.choice("Kim Kardashian")
    return_patient_array.first.update_name("Kim Kardashian West")
    return_patient_array1 = Patient.choice("Kim Kardashian West")
    expect(return_patient_array1.first.name).to eq "Kim Kardashian West"
  end

end
