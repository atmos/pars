require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::LvmBackup::Parser, "parsing" do
  before(:all) do
    @parser = Pars::LvmBackup::Parser.new
  end
  describe "to a integer" do
    before(:all) do
      @result = @parser.parse("foo = 42\n")        
    end
    it "should return a kind of LvmBackup::AssignemtnOperation" do
      @result.should be_a_kind_of(LvmBackupFileYouShouldntUse::FileContents)        
    end

    describe "evaluated output" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should return a hash of the evaluated string" do
        @evaluated_result.should be_a_kind_of(Hash)          
      end
      it "should be able to lookup the variable name" do
        @evaluated_result['foo'].should eql(42)          
      end        
    end

    describe "commented out" do
      before(:all) do
        @result = @parser.parse("foo = 42 #Answer to Life, the Universe, and Everything\n")
        @evaluated_result = @result.eval({})
      end
      it "should return a hash of the evaluated string" do
        @evaluated_result.should be_a_kind_of(Hash)          
      end
      it "should be able to lookup the variable name" do
        @evaluated_result['foo'].should eql(42)          
      end
    end
  end
end