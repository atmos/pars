require File.dirname(__FILE__) + '/../spec_helper'

describe Pars::LvmBackup::Parser, "parsing" do
  before(:all) do
    @parser = Pars::LvmBackup::Parser.new
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
        @result.should be_a_kind_of(LvmBackupFileYouShouldntUse::FileContents)      
      end
      describe "evaluated output" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return a hash of attributes" do
          @evaluated_result.should be_a_kind_of(Hash)
        end
        it "should have a value for the parsed block name" do
          @evaluated_result['foo']['bar'].should be_nil
        end
      end
    end
    describe "nested" do
      before(:all) do
        str = <<-EOF
foo {
  bar {
    baz = 42
    zab = 24
  }
}
EOF
        @result = @parser.parse(str)
      end
      it "should return a non nil result" do
        @result.should_not be_nil
      end
      it "should return a kind of LvmBackup::BlockOperation" do
        @result.should be_a_kind_of(LvmBackupFileYouShouldntUse::FileContents)      
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
        it "should have a value for the parsed block name" do
          @evaluated_result['foo']['bar']['zab'].should eql(24)
        end
      end
    end
  end
end
