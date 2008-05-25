require File.dirname(__FILE__) + '/spec_helper'

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end
  after(:each) do
    pp @parser
  end
  describe "literals" do
    it "should parse the string zomg" do
      @parser.parse('zomg').should be_nil
    end
  end

  it "should parse little ghetto block things" do
    @parser.parse('foo { bar }').should_not be_nil
  end

  it "should handle assignment to a string" do
    @parser.parse('foo = "bar"').should_not be_nil
  end
  
end