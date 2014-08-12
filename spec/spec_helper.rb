require "doctor"
require "patient"
require "specialty"
require "insurance"
require "appointment"
require "pg"
require "rspec"

DB = PG.connect(:dbname => "doctors_office")

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM appointment *;")
    DB.exec("ALTER SEQUENCE appointment_id_seq RESTART WITH 1;")
    DB.exec("DELETE FROM doctor *;")
    DB.exec("ALTER SEQUENCE doctor_id_seq RESTART WITH 1;")
    DB.exec("DELETE FROM insurance *;")
    DB.exec("ALTER SEQUENCE insurance_id_seq RESTART WITH 1;")
    DB.exec("DELETE FROM patient *;")
    DB.exec("ALTER SEQUENCE patient_id_seq RESTART WITH 1;")
    DB.exec("DELETE FROM specialty *;")
    DB.exec("ALTER SEQUENCE specialty_id_seq RESTART WITH 1;")
  end
end
