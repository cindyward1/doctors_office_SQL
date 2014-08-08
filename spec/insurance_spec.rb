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

end
