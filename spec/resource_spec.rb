require 'rspec_helper'

describe OM::Api::Resource do
  subject { OM::Api::Resource.new }

  it "should be a hash" do
    subject.should be_kind_of(Hash)
  end

  it "should provide . access to keys in the hash" do
    subject.merge!("x" => "y")
    subject.x.should == "y"
  end

  it "should absorb hashes" do
    hash = { "x" => "y" }
    OM::Api::Resource.absorb(hash).should eq hash
  end

  it "should absorb complex structeres" do
    hash = { "x" => { "x" => { "x" => "y", "array" => [ 1, 2, { "x" => "y" } ] } } }
    resource = OM::Api::Resource.absorb(hash)
    resource.should eq hash

    resource.x.x.x.should eq "y"
    resource.x.x.array.should be_kind_of(Array)
    resource.x.x.array[2].x.should eq "y"
  end

  it "should raise NoMethodError on undefined keys" do
    expect { subject.ne_existe_pas }.to raise_error(NoMethodError)
  end
end
