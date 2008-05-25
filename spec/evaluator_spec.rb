require File.dirname(__FILE__) + '/spec_helper'

describe Evaluator, "do it big like the rappers" do
  before(:all) do
    @test = Evaluator.new("version = 1\ntags = [\"ey02-s00327\", \"ey02-e00208\"]")
  end
  it "should respond to tags" do
    @test.should respond_to(:tags)
  end
  it "should respond to version" do
    @test.should respond_to(:version)
  end
  it "should have two instance variables" do
    @test.instance_variables.should have(3).things
  end
  
  it "should handle the first round of weird shit i throw at it" do
    @test = Evaluator.new("hello { i = 0 }")
    @test.keys[:hello] = { :i => 0 }
  end

end
