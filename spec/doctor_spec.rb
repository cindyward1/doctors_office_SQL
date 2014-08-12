require "spec_helper"
describe Doctor do
  it "is initialized with a name" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    expect(test_doctor).to be_an_instance_of Doctor
  end

  it "tells you his/her name" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    expect(test_doctor.name).to eq "Who"
  end

  it "tells you his/her specialty" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    expect(test_doctor.specialty_id).to eq test_specialty.id
  end

  it "tells you the insurance he/she accepts" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    expect(test_doctor.insurance_id).to eq test_insurance.id
  end

   it "is initialized with an empty array" do
    expect(Doctor.all).to eq []
  end

  it "saves a doctor to the empty array" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    test_doctor.save
    expect(Doctor.all).to eq [test_doctor]
  end

  it "finds a specific doctor based on name" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    test_doctor.save
    expect(Doctor.choice("Who")).to eq [test_doctor]
  end

  it "will change the name of a specific doctor" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    test_doctor.save
    return_doctor_array = Doctor.choice("Who")
    return_doctor_array.first.update_name("McCoy")
    return_doctor_array2 = Doctor.choice("McCoy")
    expect(return_doctor_array2.first.name).to eq "McCoy"
  end


  it "updates the insurance for a specific doctor" do
    test_insurance1 = Insurance.new({:name=>"Red Shield"})
    test_insurance1.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance1.id})
    test_doctor.save
    return_doctor_array = Doctor.choice("Who")
    test_insurance2 = Insurance.new({:name=>"Green Arrow"})
    test_insurance2.save
    return_doctor_array.first.update_insurance(test_insurance2.id)
    return_doctor_array2 = Doctor.choice("Who")
    expect(return_doctor_array2.first.insurance_id).to eq test_insurance2.id
  end

  it "updates the specialty for a specific doctor" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty1 = Specialty.new({:name=>"Time travel"})
    test_specialty1.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty1.id,
                              :insurance_id=>test_insurance.id})
    test_doctor.save
    return_doctor_array = Doctor.choice("Who")
    test_specialty2 = Specialty.new({:name=>"Plastic surgery"})
    test_specialty2.save
    return_doctor_array.first.update_specialty(test_specialty2.id)
    return_doctor_array2 = Doctor.choice("Who")
    expect(return_doctor_array2.first.specialty_id).to eq test_specialty2.id
  end

end
