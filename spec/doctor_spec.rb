require "spec_helper"
describe Doctor do
  it "is initialized with a name" do
    test_doctor = Doctor.new(:name => "Who")
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it "tells you his/her name" do
    test_doctor = Doctor.new({:name=>"Who"})
    expect(test_doctor.name).to eq "Who"
  end

  it "tells you his/her specialty" do
    test_doctor = Doctor.new({:name=>"Who"})
    test_specialty = Specialty.new({:name=>"Time travel", :id=>1})
    test_doctor.specialty_add(test_specialty.id)
    expect(test_doctor.specialty_id).to eq test_specialty.id
  end

  it "tells you the insurance he/she accepts" do
    test_doctor = Doctor.new({:name=>"Who"})
    test_insurance = Insurance.new({:name=>"Red Shield", :id=>1})
    test_doctor.insurance_add(test_insurance.id)
    expect(test_doctor.insurance_id).to eq test_insurance.id
  end

   it "is initialized with an empty array" do
    expect(Doctor.all).to eq []
  end

  it "saves a doctor to the empty array" do
    test_doctor = Doctor.new({:name=>"Who"})
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_doctor.insurance_add(test_insurance.id)
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor.specialty_add(test_specialty.id)
    test_doctor.save
    expect(Doctor.all).to eq [test_doctor]
  end

end
