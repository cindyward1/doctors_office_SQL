require "spec_helper"

describe Appointment do
  it "will be intitialized with a doctor, patient, and a date" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    test_doctor.save
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    test_appointment = Appointment.new({:doctor_id => test_doctor.id, :patient_id => test_patient.id,
                                        :date => "01/05/2015", :cost=>25})
    expect(test_appointment).to be_an_instance_of Appointment
  end

  it "will tell you the name of the doctor id, patient id, and date of the appointment" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    test_doctor.save
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    test_patient.save
    test_appointment = Appointment.new({:doctor_id => test_doctor.id, :patient_id => test_patient.id,
                                        :date => "01/05/2015", :cost=>25})
    expect(test_appointment.doctor_id).to eq test_doctor.id
    expect(test_appointment.patient_id).to eq test_patient.id
    expect(test_appointment.date).to eq "01/05/2015"
    expect(test_appointment.cost).to eq 25
  end

  it "starts with an empty array" do
    expect(Appointment.all).to eq []
  end

  it "saves an appointment to the empty array" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    test_insurance.save
    test_specialty = Specialty.new({:name=>"Time travel"})
    test_specialty.save
    test_doctor = Doctor.new({:name=>"Who", :specialty_id=>test_specialty.id,
                              :insurance_id=>test_insurance.id})
    test_doctor.save
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthday=>"08/01/1983"})
    test_patient.save
    test_appointment = Appointment.new({:doctor_id => test_doctor.id, :patient_id => test_patient.id,
                                        :date => "01/05/2015", :cost=>25})
    test_appointment.save
    expect(Appointment.all).to eq [test_appointment]
  end

end
