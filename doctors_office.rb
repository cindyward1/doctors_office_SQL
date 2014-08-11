require "./lib/appointment.rb"
require "./lib/doctor.rb"
require "./lib/insurance.rb"
require "./lib/specialty.rb"
require "./lib/patient.rb"
require "pg"

DB = PG.connect(:dbname => "doctors_office")

def main_menu

  puts "\nWelcome to the Doctor's Office application\n"

  option = ""

  while option != "x"

    puts "\nMenu options:"
    puts "  m = main_menu (this menu)"
    puts "  x = exit program"
    puts "  p = patient menu"
    puts "  i = insurance company menu"
    puts "  s = doctor specialty menu"
    puts "  d = doctor menu"
    puts "  a = add appointment"
    puts "\n"

    puts "What would you like to do?"
    option = gets.chomp.downcase
    if option == "p"
      patient_menu
    elsif option == "i"
      insurance_menu
    elsif option == "s"
      specialty_menu
    elsif option == "d"
      doctor_menu
    elsif option == "a"
      add_appointment
    elsif option == "x"
      puts "\nThanks for using the Doctor's Appointment application"
      exit
    elsif option != "m"
      puts "Invalid option, please try again"
    end
  end

end

def patient_menu

  puts "\nMenu options:"
  puts "  m = main_menu (this menu)"
  puts "  x = exit program"
  puts " Patient options:"
  puts "  a = add patient"
  puts "  l = list all patients"
  puts "  e = edit patient (change name and/or birthday)"
  puts "  d = delete patient"
  puts "  f = find patient by name"
  puts "\n"

  puts "What would you like to do now?"
  option = gets.chomp

  if option == "a"
    add_patient
  elsif option == "l"
    list_patient
  elsif option == "e"
    edit_patient
  elsif option == "d"
    delete_patient
  elsif option == "f"
    find_patient
  elsif option == "x"
    puts "\nThanks for using the Doctor's Appointment application"
    exit
  elsif option != "m"
    puts "Invalid option, please try again"
  end
end

def add_patient
  puts "Please enter the patient's name:"
  name_input = gets.chomp
  puts "Please enter the patient's birthday (format MM/DD/YYYY):"
  bday_input = gets.chomp
  if bday_input !~ /\d\d\/\d\d\/\d\d\d\d/
    puts "\nInvalid format for birthday, please try again\n"
    add_patient
  end
  new_patient = Patient.new({:name => name_input, :birthday => bday_input})
  new_patient.save
end

def list_patient
  puts "The list of patients is:"
  Patient.all.each do |patient|
    puts "#{patient.id.to_s}. #{patient.name}, birthday = #{patient.birthday}"
  end
  puts "\n"
end

def edit_patient
  list_patient

  puts "Which patient would you like to change?"
  patient_id = gets.chomp.to_i

  the_patient = Patient.choice_by_id(patient_id).first

  puts "\nWould you like to change the patient's name? ('y' or 'yes' to change)"
  answer = gets.chomp.downcase
  if answer.slice(0,1) == "y"
    puts "\nPlease enter the new patient name"
    new_name = gets.chomp
    the_patient.update_name(new_name)
    puts "The patient's name was updated to #{new_name}\n"
  end

  puts "\nWould you like to change the patient's birthday? ('y' or 'yes' to change)"
  answer = gets.chomp
  if answer.slice(0,1) == "y"
    puts "\nPlease enter the new patient birthday"
    new_birthday = gets.chomp
    if new_birthday !~ /\d\d\/\d\d\/\d\d\d\d/
      puts "\nInvalid format for birthday, please try again\n"
      edit_patient
    else
      the_patient.update_birthday(new_birthday)
      puts "The patient's birthday was updated to #{new_birthday}"
    end
  end
end

def delete_patient
  list_patient

  puts "Which patient would you like to delete?"
  patient_id = gets.chomp.to_i
  the_patient = Patient.choice_by_id(patient_id).first
  the_patient.delete
  puts "The patient #{the_patient.name} has been deleted!"
end

def find_patient
  puts "What is the name of the patient you want to find?"
  patient_name = gets.chomp

  if Patient.choice(patient_name).length > 0
    puts "The patient #{patient_name} was found"
  else
    puts "The patient #{patient_name} was not found"
  end
end

def insurance_menu

  puts "\nMenu options:"
  puts "  m = main_menu (this menu)"
  puts "  x = exit program"
  puts " Insurance company options:"
  puts "  a = add insurance company"
  puts "  l = list all insurance companies"
  puts "  e = edit insurance company (change name)"
  puts "  d = delete insurance company"
  puts "\n"

  puts "What would you like to do now?"
  option = gets.chomp

  if option == "a"
    add_insurance
  elsif option == "l"
    list_insurance
  elsif option == "e"
    edit_insurance
  elsif option == "d"
    delete_insurance
  elsif option == "x"
    puts "\nThanks for using the Doctor's Appointment application"
    exit
  elsif option != "m"
    puts "Invalid option, please try again"
  end
end

def add_insurance
  puts "Please enter the insurance company's name:"
  name_input = gets.chomp

  new_insurance = Insurance.new({:name => name_input})
  new_insurance.save
end

def list_insurance
  puts "The list of insurance companies is:"
  Insurance.all.each do |insurance|
    puts "#{insurance.id.to_s}. #{insurance.name}"
  end
  puts "\n"
end

def edit_insurance
  list_insurance

  puts "Which insurance company would you like to change?"
  insurance_id = gets.chomp.to_i

  the_company = Insurance.choice_by_id(insurance_id).first

  puts "\nWould you like to change the insurance company's name? ('y' or 'yes' to change)"
  answer = gets.chomp.downcase
  if answer.slice(0,1) == "y"
    puts "\nPlease enter the new insurance company name"
    new_name = gets.chomp
    the_company.update_name(new_name)
    puts "The insurance company's name was updated to #{new_name}\n"
  end
end

def delete_insurance
  list_insurance

  puts "Which insurance company would you like to delete?"
  insurance_id = gets.chomp.to_i
  the_company = Insurance.choice_by_id(insurance_id).first
  the_company.delete
  puts "The insurance company #{the_company.name} has been deleted!"
end

def specialty_menu

  puts "\nMenu options:"
  puts "  m = main_menu (this menu)"
  puts "  x = exit program"
  puts " Specialty options:"
  puts "  a = add specialty"
  puts "  l = list all specialties"
  puts "  e = edit specialty (change name)"
  puts "  d = delete specialty"
  puts "\n"

  puts "What would you like to do now?"
  option = gets.chomp

  if option == "a"
    add_specialty
  elsif option == "l"
    list_specialty
  elsif option == "e"
    edit_specialty
  elsif option == "d"
    delete_specialty
  elsif option == "x"
    puts "\nThanks for using the Doctor's Appointment application"
    exit
  elsif option != "m"
    puts "Invalid option, please try again"
  end
end

def add_specialty
  puts "Please enter the specialty name:"
  name_input = gets.chomp

  new_specialty = Specialty.new({:name => name_input})
  new_specialty.save
end

def list_specialty
  puts "The list of all specialties is:"
  Specialty.all.each do |specialty|
    puts "#{specialty.id.to_s}. #{specialty.name}"
  end
  puts "\n"
end

def edit_specialty
  list_specialty

  puts "Which specialty would you like to change?"
  specialty_id = gets.chomp.to_i

  the_specialty = Specialty.choice_by_id(specialty_id).first

  puts "\nWould you like to change the specialty's name? ('y' or 'yes' to change)"
  answer = gets.chomp.downcase
  if answer.slice(0,1) == "y"
    puts "\nPlease enter the new specialty name"
    new_name = gets.chomp
    the_specialty.update_name(new_name)
    puts "The specialty's name was updated to #{new_name}\n"
  end
end

def delete_specialty
  list_specialty

  puts "Which specialty would you like to delete?"
  specialty_id = gets.chomp.to_i
  the_specialty = Specialty.choice_by_id(specialty_id).first
  the_specialty.delete
  puts "The specialty #{the_specialty.name} has been deleted!"
end

def doctor_menu

  puts "\nMenu options:"
  puts "  m = main_menu (this menu)"
  puts "  x = exit program"
  puts " Doctor options:"
  puts "  a = add doctor"
  puts "  l = list all doctors"
  puts "  e = edit doctor (change name and/or birthday)"
  puts "  d = delete doctor"
  puts "\n"

  puts "What would you like to do now?"
  option = gets.chomp

  if option == "a"
    add_doctor
  elsif option == "l"
    list_doctor
  elsif option == "e"
    edit_doctor
  elsif option == "d"
    delete_doctor
  elsif option == "x"
    puts "\nThanks for using the Doctor's Appointment application"
    exit
  elsif option != "m"
    puts "Invalid option, please try again"
  end
end

def add_doctor
  puts "Please enter the doctor's name:"
  name_input = gets.chomp
  list_specialty
  puts "Please select the doctor's specialty"
  specialty_input = gets.chomp.to_i
  list_insurance
  puts "Please select the doctor's accepted insurance company"
  insurance_input = gets.chomp.to_i
  new_doctor = Doctor.new({:name => name_input, :specialty_id => specialty_input, :insurance_id => insurance_input})
  new_doctor.save
end

def list_doctor
  puts "The list of doctors is:"
  Doctor.all.each do |doctor|
    puts "#{doctor.id.to_s}. #{doctor.name}"
  end
  puts "\n"
end

def edit_doctor
  list_doctor

  puts "Which doctor would you like to change?"
  doctor_id = gets.chomp.to_i

  the_doctor = Doctor.choice_by_id(doctor_id).first

  puts "\nWould you like to change the doctor's name? ('y' or 'yes' to change)"
  answer = gets.chomp.downcase
  if answer.slice(0,1) == "y"
    puts "\nPlease enter the new doctor name"
    new_name = gets.chomp
    the_doctor.update_name(new_name)
    puts "The doctor's name was updated to #{new_name}\n"
  end
end

def delete_doctor
  list_doctor
  puts "Which doctor would you like to delete?"
  doctor_id = gets.chomp.to_i
  the_doctor = Doctor.choice_by_id(doctor_id).first
  the_doctor.delete
  puts "The doctor #{the_doctor.name} has been deleted!"
end

def add_appointment
  list_doctor
  puts "Please select the doctor"
  doctor_input = gets.chomp.to_i

  list_patient
  puts "Please select the patient"
  patient_input = gets.chomp.to_i

  puts "\nPlease enter the date of the appointment (format 'MM/DD/YYYY')"
  appointment_date = gets.chomp
  if appointment_date !~ /\d\d\/\d\d\/\d\d\d\d/
    puts "\nInvalid format for appointment date, please try again\n"
    add_appointment
  end

  puts "\nPlease enter a cost for the appointment in dollars"
  appointment_cost = gets.chomp.to_i

  new_appointment = Appointment.new({:doctor_id => doctor_input, :patient_id => patient_input,
                                        :date => appointment_date,
                                        :cost => appointment_cost})
  new_appointment.save
end

main_menu
