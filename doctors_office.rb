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
      puts "\nThanks for using the Doctor's Appointment application\n"
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
  puts "  e = edit patient (change name and/or birthday and/or doctor)"
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
    puts "\nThanks for using the Doctor's Appointment application\n"
    exit
  elsif option != "m"
    puts "Invalid option, please try again"
  end
end

# PATIENT
def add_patient
  puts "Please enter the patient's name"
  name_input = gets.chomp
  puts "Please enter the patient's birthday (format MM/DD/YYYY)"
  bday_input = gets.chomp
  if bday_input !~ /\d\d\/\d\d\/\d\d\d\d/
    puts "\nInvalid format for birthday, please try again\n"

  else
    list_doctor
    puts "Please select the ID of the patient's doctor"
    doctor_input = gets.chomp.to_i
    if doctor_input == 0
      puts "Invalid doctor entry, please try again"
    
    else
      new_patient = Patient.new({:name => name_input, :birthday => bday_input,
                             :doctor_id => doctor_input})
      new_patient.save
    end
  end
end

def list_patient
  puts "\nThe list of patients\n\n"
  Patient.all.each do |patient|
    if Doctor.choice_by_id(patient.doctor_id).length > 0
      doctor_name = Doctor.choice_by_id(patient.doctor_id).first.name
    else
      doctor_name = "None"
    end
    puts "#{patient.id.to_s}. #{patient.name}:  birthday #{patient.birthday}, doctor #{doctor_name}"
  end
  puts "\n"
end

def edit_patient
  list_patient
  puts "Please select the ID of the patient you would like to change"
  patient_id = gets.chomp.to_i
  if patient_id == 0
    puts "Invalid patient entry, please try again"
    edit_patient
  else
    the_patient = Patient.choice_by_id(patient_id).first

    puts "\nWould you like to change the patient's name? Enter 'y' or 'yes' to change, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      puts "\nPlease enter the new patient name"
      new_name = gets.chomp
      the_patient.update_name(new_name)
      puts "The patient's name was updated to #{new_name}\n"
    end

    puts "\nWould you like to change the patient's birthday? Enter 'y' or 'yes' to change, anything else to skip"
    answer = gets.chomp
    if answer.slice(0,1) == "y"
      puts "\nPlease enter the new patient birthday"
      new_birthday = gets.chomp
      if new_birthday !~ /\d\d\/\d\d\/\d\d\d\d/
        puts "\nInvalid format for birthday, please try again\n"
      else
        the_patient.update_birthday(new_birthday)
        puts "The patient's birthday was updated to #{new_birthday}"
      end
    end

    puts "\nWould you like to change the patient's doctor? Enter 'y' or 'yes' to change, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      list_doctor
      puts "Please select the ID of patient's new doctor"
      doctor_input = gets.chomp.to_i
      if doctor_input == 0
        puts "Invalid doctor entry, please try again"
      else
        the_patient.update_doctor_id(doctor_input)
        doctor_name = Doctor.choice_by_id(doctor_input)
        puts "The patient's doctor was updated to #{doctor_name.first.name}"
      end
    end
  end
end

def delete_patient
  list_patient
  puts "Please select the ID of the patient you would like to delete (this CANNOT be undone!)"
  patient_id = gets.chomp.to_i
  if patient_id == 0
    puts "Invalid patient entry, please try again"
  else
    the_patient = Patient.choice_by_id(patient_id).first
  
    puts "Do you REALLY want to delete #{the_patient.name}? Enter 'y' or 'yes' to delete, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      the_patient.delete
      puts "The patient #{the_patient.name} has been deleted!"
    else
      puts "Nothing was deleted"
    end
  end
end

def find_patient
  puts "Please enter the name of the patient you would like to find"
  patient_name = gets.chomp
  patient = Patient.choice(patient_name)

  if patient.length > 0
    if Doctor.choice_by_id(patient.first.doctor_id).length > 0
      doctor_name = Doctor.choice_by_id(patient.first.doctor_id).first.name
    else
      doctor_name = "None"
    end
    puts "Patient #{patient.first.name} was found: id #{patient.first.id}, birthday #{patient.first.birthday}, " +
                                                  "doctor #{doctor_name}"
  else
    puts "Patient #{patient_name} was not found"
  end
end

# INSURANCE
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
    puts "\nThanks for using the Doctor's Appointment application\n"
    exit
  elsif option != "m"
    puts "Invalid option, please try again"
  end
end

def add_insurance
  puts "Please enter the insurance company's name"
  name_input = gets.chomp
  new_insurance = Insurance.new({:name => name_input})
  new_insurance.save
end

def list_insurance
  puts "\nThe list of insurance companies\n"
  Insurance.all.each do |insurance|
    puts "#{insurance.id.to_s}. #{insurance.name}"
  end
  puts "\n"
end

def edit_insurance
  list_insurance
  puts "Please select the ID of the insurance company you would like to change"
  insurance_id = gets.chomp.to_i
  if insurance_id == 0
    puts "Invalid insurance company entry, please try again"
  else
    the_company = Insurance.choice_by_id(insurance_id).first

    puts "\nWould you like to change the insurance company's name? Enter 'y' or 'yes' to change, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      puts "\nPlease enter the new insurance company name"
      new_name = gets.chomp
      the_company.update_name(new_name)
      puts "The insurance company's name was updated to #{new_name}\n"
    end
  end
end

def delete_insurance
  list_insurance
  puts "Please enter the ID of the insurance company you would like to delete (this CANNOT be undone!)"
  insurance_id = gets.chomp.to_i
  if insurance_id == 0
    puts "Invalid insurance company entry, please try again"
  else
    the_company = Insurance.choice_by_id(insurance_id).first

    puts "Do you REALLY want to delete #{the_company.name}? Enter 'y' or 'yes' to delete, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      the_company.delete
      puts "The insurance company #{the_company.name} has been deleted"
    else
      puts "Nothing was deleted"
    end
  end
end

# SPECIALTY
def specialty_menu

  puts "\nMenu options:"
  puts "  m = main_menu (this menu)"
  puts "  x = exit program"
  puts " Specialty options:"
  puts "  a = add specialty"
  puts "  l = list all specialties"
  puts "  s = list the doctors for all specialties"
  puts "  e = edit specialty (change name)"
  puts "  d = delete specialty"
  puts "\n"

  puts "What would you like to do now?"
  option = gets.chomp

  if option == "a"
    add_specialty
  elsif option == "l"
    list_specialty
  elsif option == "s"
    list_doctors_per_specialty
  elsif option == "e"
    edit_specialty
  elsif option == "d"
    delete_specialty
  elsif option == "x"
    puts "\nThanks for using the Doctor's Appointment application\n"
    exit
  elsif option != "m"
    puts "Invalid option, please try again"
  end
end

def add_specialty
  puts "Please enter the specialty name"
  name_input = gets.chomp
  new_specialty = Specialty.new({:name => name_input})
  new_specialty.save
end

def list_specialty
  puts "\nThe list of all specialties\n\n"
  Specialty.all.each do |specialty|
    puts "#{specialty.id.to_s}. #{specialty.name}"
  end
  puts "\n"
end

def edit_specialty
  list_specialty
  puts "Please select the ID of the specialty you would like to change"
  specialty_id = gets.chomp.to_i
  if specialty_id == 0
    puts "Invalid specialty entry, please try again"
    edit_specialty
  else
    the_specialty = Specialty.choice_by_id(specialty_id).first

    puts "\nWould you like to change the specialty's name? Enter 'y' or 'yes' to change, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      puts "\nPlease enter the new specialty name"
      new_name = gets.chomp
      the_specialty.update_name(new_name)
      puts "The specialty's name was updated to #{new_name}\n"
    end
  end
end

def delete_specialty
  list_specialty
  puts "Please select the ID of specialty you would like to delete (this CANNOT be undone!)"
  specialty_id = gets.chomp.to_i
  if specialty_id == 0
    puts "Invalid specialty entry, please try again"
    delete_specialty
  else
    the_specialty = Specialty.choice_by_id(specialty_id).first
  
    puts "Do you REALLY want to delete #{the_specialty.name}? Enter 'y' or 'yes' to delete, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      the_specialty.delete
      puts "The specialty #{the_specialty.name} has been deleted!"
    else
      puts "Nothing was deleted"
    end
  end
end

def list_doctors_per_specialty
  puts "\nThe doctors per specialty\n\n"
  Specialty.all.each do |specialty|
    puts "#{specialty.name}"
    specialty.list_doctors.each do |doctor|
      puts "    #{doctor.name}"
    end
  end
  puts "\n"
end

# DOCTOR
def doctor_menu

  puts "\nMenu options:"
  puts "  m = main_menu (this menu)"
  puts "  x = exit program"
  puts " Doctor options:"
  puts "  a = add doctor"
  puts "  l = list all doctors"
  puts "  c = list patient counts for all doctors"
  puts "  b = show all billing dollars for a doctor"
  puts "  t = show billing dollars for a doctor in a specific time period"
  puts "  e = edit doctor (change name and/or accepted insurance company and/or specialty"
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
  elsif option == "c"
    count_patients_per_doctor
  elsif option == "b"
    show_billing_doctor
  elsif option == "t"
    show_billing_doctor_time
  elsif option == "x"
    puts "\nThanks for using the Doctor's Appointment application\n"
    exit
  elsif option != "m"
    puts "Invalid option, please try again"
  end
end

def add_doctor
  puts "Please enter the doctor's name"
  name_input = gets.chomp

  list_specialty
  puts "Please select the ID of the doctor's specialty"
  specialty_input = gets.chomp.to_i
  if specialty_input == 0
    puts "Invalid specialty entry, please try again"
  else

    list_insurance
    puts "Please select the ID of the doctor's accepted insurance company"
    insurance_input = gets.chomp.to_i
    if insurance_input == 0
      puts "Invalid insurance company entry, please try again"
    else
      new_doctor = Doctor.new({:name => name_input, :specialty_id => specialty_input, :insurance_id => insurance_input})
      new_doctor.save
    end
  end
end

def list_doctor
  puts "\nThe list of doctors\n\n"
  Doctor.all.each do |doctor|
    if Specialty.choice_by_id(doctor.specialty_id).length > 0
      specialty_name = Specialty.choice_by_id(doctor.specialty_id).first.name
    else
      specialty_name = "None"
    end
    if Insurance.choice_by_id(doctor.insurance_id).length > 0
      insurance_name = Insurance.choice_by_id(doctor.insurance_id).first.name
    else
      insurance_name = "None"
    end
    puts "#{doctor.id.to_s}. #{doctor.name}:  specialty #{specialty_name}, insurance #{insurance_name}"
  end
  puts "\n"
end

def edit_doctor
  list_doctor
  puts "Please select the ID of the doctor you would like to change"
  doctor_id = gets.chomp.to_i
  if doctor_id == 0
    puts "Invalid doctor entry, please try again"
    edit_doctor
  else
    the_doctor = Doctor.choice_by_id(doctor_id).first

    puts "\nWould you like to change the doctor's name? Enter 'y' or 'yes' to change, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      puts "\nPlease enter the new doctor name"
      new_name = gets.chomp
      the_doctor.update_name(new_name)
      puts "The doctor's name was updated to #{new_name}\n"
    end

    puts "\nWould you like to change the doctor's specialty? Enter 'y' or 'yes' to change, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      list_specialty
      puts "Please select the ID of the doctor's specialty"
      specialty_input = gets.chomp.to_i
      if specialty_input == 0
        puts "Invalid specialty entry, please try again"
      else
        the_doctor.update_specialty(specialty_input)
        if Specialty.choice_by_id(specialty_input).length > 0
          specialty_name = Specialty.choice_by_id(specialty_input).first.name
        else
          specialty_name = "None"
        end
        puts "The doctor's specialty was updated to #{specialty_name}"
      end
    end

    puts "\nWould you like to change the doctor's accepted insurance company? Enter 'y' or 'yes' to change, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      list_insurance
      puts "Please select the ID of the doctor's accepted insurance company"
      insurance_input = gets.chomp.to_i
      if insurance_input == 0
        puts "Invalid insurance company entry, please try again"
      else
        the_doctor.update_insurance(insurance_input)
        if Insurance.choice_by_id(insurance_input).length > 0
          insurance_name = Insurance.choice_by_id(insurance_input).first.name
        else
          insurance_name = "None"
        end
        puts "The doctor's accepted insurance company was updated to #{insurance_name}"
      end
    end
  end
end

def delete_doctor
  list_doctor
  puts "Please select the ID of the doctor you would like to delete"
  doctor_id = gets.chomp.to_i
  if doctor_id == 0
    puts "Invalid doctor entry, please try again"
  else
    the_doctor = Doctor.choice_by_id(doctor_id).first

    puts "Do you REALLY want to delete #{the_doctor.name}? Enter 'y' or 'yes' to delete, anything else to skip"
    answer = gets.chomp.downcase
    if answer.slice(0,1) == "y"
      the_doctor.delete
      puts "The doctor #{the_doctor.name} has been deleted"
    else
      puts "Nothing was deleted"
    end
  end
end

def count_patients_per_doctor
  puts "\nThe patient count per doctor\n"
  Doctor.count_patient.each do |doctor|
    puts "#{doctor.name}:  patient count #{doctor.patient_count.to_s}"
  end
  puts "\n"
end

def show_billing_doctor
  list_doctor
  puts "Please select the doctor whose billings would you like to calculate"
  doctor_input = gets.chomp.to_i
  if doctor_input == 0
    puts "Invalid doctor entry, please try again"
  else
    the_doctor = Doctor.choice_by_id(doctor_input).first
    doctor_sum = the_doctor.get_sum_for_doctor
    puts "\The billings for #{the_doctor.name} were $#{doctor_sum}"
  end
end

def show_billing_doctor_time
  list_doctor
  puts "Please select the doctor whose billings would you like to calculate"
  doctor_input = gets.chomp.to_i
  if doctor_input == 0
    puts "Invalid doctor entry, please try again"
  else
    the_doctor = Doctor.choice_by_id(doctor_input).first
    p the_doctor

    puts "Please enter the start date for calculating #{the_doctor.name}'s billings (format MM/DD/YYYY)"
    start_date = gets.chomp
    if start_date !~ /\d\d\/\d\d\/\d\d\d\d/
      puts "\nInvalid format for start date, please try again\n"
    else

      puts "Please enter the end date for calculating #{the_doctor.name}'s billings (format MM/DD/YYYY)"
      end_date = gets.chomp
      if end_date !~ /\d\d\/\d\d\/\d\d\d\d/
        puts "\nInvalid format for end date, please try again\n"
      else
        doctor_sum = the_doctor.get_sum_for_doctor_time(start_date, end_date)
        puts "\The billings for #{the_doctor.name} were $#{doctor_sum}"
      end
    end
  end
end


# APPOINTMENT
def add_appointment
  list_doctor
  puts "Please select the ID of the doctor"
  doctor_input = gets.chomp.to_i
  if doctor_input == 0
    puts "Invalid doctor entry, please try again"
  else

    list_patient
    puts "Please select the ID of the patient"
    patient_input = gets.chomp.to_i
    if patient_input == 0
      puts "Invalid patient entry, please try again"
    else

      puts "\nPlease enter the date of the appointment (format 'MM/DD/YYYY')"
      appointment_date = gets.chomp
      if appointment_date !~ /\d\d\/\d\d\/\d\d\d\d/
        puts "\nInvalid format for appointment date, please try again\n"
      else

        puts "\nPlease enter a cost for the appointment in dollars"
        appointment_cost = gets.chomp.to_i

        new_appointment = Appointment.new({:doctor_id => doctor_input, :patient_id => patient_input, :date => appointment_date, :cost => appointment_cost})
        new_appointment.save
      end
    end
  end
end

main_menu
