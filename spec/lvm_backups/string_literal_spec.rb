require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::LvmBackup::Parser, "parsing" do
  before(:all) do
    @parser = Pars::LvmBackup::Parser.new
  end

  describe "literals" do
    it "should parse the string zomg" do
      result = @parser.parse('zomg')
      result.should_not be_nil
      result.text_value.should == 'zomg'
    end
  end
end