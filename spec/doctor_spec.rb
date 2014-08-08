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
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_doctor.specialty_add(test_specialty)
    expect(test_doctor.specialty.name).to eq "Time travel"
  end

  it "tells you the insurance he/she accepts" do
    test_doctor = Doctor.new({:name=>"Who"})
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_doctor.insurance_add(test_insurance)
    expect(test_doctor.insurance.name).to eq "Red Shield"
  end

end
