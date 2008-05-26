require File.dirname(__FILE__) + '/../spec_helper'

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end
  describe "ey04-data00 as input" do
    before(:all) do
      @result = @parser.parse(File.read(File.dirname(__FILE__)+'/../fixtures/ey04-data00'))
    end
    it "shouldn't be nil" do
      @result.should_not be_nil
    end
    it "should return a kind of LvmBackup::FileContents" do
      @result.should be_a_kind_of(LvmBackup::FileContents)
    end

    describe "evaluated output" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should return a hash of the evaluated string" do
        @evaluated_result.should be_a_kind_of(Hash)          
      end
      it "should be able to lookup the variable name" do
        @evaluated_result['contents'].should eql('Text Format Volume Group')          
      end
      it "should be able to lookup the variable name" do
        @evaluated_result['version'].should eql(1)
      end
      it "should be able to access the id for the lv" do
        @evaluated_result['ey04-data00']['id'].should eql("6jKJQg-pFTD-lff8-4xwL-oGk2-z0q2-WVRHTa")
      end
    end
  end
end