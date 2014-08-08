require "spec_helper"

describe Appointment do
  it "will be intitialized with a doctor, patient, and a date" do
    test_doctor = Doctor.new({:name=>"Who"})
    test_patient = Patient.new({:name=>"Kim Kardashian", :birthdate=>"08/01/1983"})
    test_appointment = Appointment.new({:doctor => test_doctor, :patient => test_patient, :date => "01/05/2015"})
    expect(test_appointment).to be_an_instance_of Appointment
  end

end
