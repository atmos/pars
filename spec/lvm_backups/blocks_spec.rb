require File.dirname(__FILE__) + '/../spec_helper'

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end
  describe "blocks" do
    describe "simple" do
      before(:all) do
        @result = @parser.parse('foo { bar }')
      end
      it "should return a non nil result" do
        @result.should_not be_nil      
      end
      it "should return a kind of LvmBackup::BlockOperation" do
        @result.should be_a_kind_of(LvmBackup::FileContents)      
      end
      describe "evaluated output" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return a hash of attributes" do
          @evaluated_result.should be_a_kind_of(Hash)
        end
        it "should have a value for the parsed block name" do
          @evaluated_result['foo'].should eql('bar')
        end
      end
    end
    describe "nested" do
      before(:all) do
        @result = @parser.parse('foo { bar { baz = 42\nzab = 24 } }')
      end
      it "should return a non nil result" do
        @result.should_not be_nil
      end
      it "should return a kind of LvmBackup::BlockOperation" do
        @result.should be_a_kind_of(LvmBackup::FileContents)      
      end
      describe "evaluated output" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return a hash of attributes" do
          @evaluated_result.should be_a_kind_of(Hash)
        end
        it "should have a value for the parsed block name" do
          @evaluated_result['foo']['bar']['baz'].should eql(42)
        end
      end
    end
  end
end
