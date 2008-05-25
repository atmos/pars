require File.dirname(__FILE__) + '/../spec_helper'

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end

  describe "literals" do
    it "should parse the string zomg" do
      result = @parser.parse('zomg')
      result.should_not be_nil
      result.text_value.should == 'zomg'
    end
  end
end