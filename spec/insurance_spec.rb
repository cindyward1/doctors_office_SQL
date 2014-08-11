require "spec_helper"
describe Insurance do
  it "is initialized with a name" do
    test_insurance = Insurance.new({:name => "Red Shield"})
    expect(test_insurance).to be_an_instance_of Insurance
  end

  it "tells you its name" do
    test_insurance = Insurance.new({:name=>"Red Shield"})
    expect(test_insurance.name).to eq "Red Shield"
  end

  it "starts with an empty array" do
    expect(Insurance.all).to eq []
  end

  it "saves an insurance company to the empty array" do
    test_insurance = Insurance.new({:name => "Red Shield"})
    test_insurance.save
    expect(Insurance.all).to eq [test_insurance]
  end

  it "will choose and return a specific insurance company based on the name" do
    test_insurance = Insurance.new({:name => "Red Shield"})
    test_insurance.save
    expect(Insurance.choice("Red Shield")).to eq [test_insurance]
  end

  it "will delete a specific insurance company based on the insurance company's name" do
    test_insurance = Insurance.new({:name => "Red Shield"})
    test_insurance.save
    return_insurance_array = Insurance.choice("Red Shield")
    return_insurance_array.first.delete
    expect(Insurance.all).to eq []
  end

  it "will change the name of a specific insurance company" do
    test_insurance = Insurance.new({:name => "Red Shield"})
    test_insurance.save
    return_insurance_array = Insurance.choice("Red Shield")
    return_insurance_array.first.update_name("Green Shield")
    return_insurance_array1 = Insurance.choice("Green Shield")
    expect(return_insurance_array1.first.name).to eq "Green Shield"
  end
end
