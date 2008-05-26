require File.dirname(__FILE__) + '/../spec_helper'

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end
  describe "assignment" do
    describe "to a quoted string" do
      before(:all) do
        @result = @parser.parse("foo = \"bar\"\n")        
      end
      it "should return a kind of LvmBackup::AssignemtnOperation" do
        @result.should be_a_kind_of(LvmBackup::AssignmentOperation)        
      end
      it "should have a varname for the left hand side of the expression" do
        @result.varname.text_value.should == 'foo'        
      end
      it "should have a varvalue for the right hand side of the expression" do
        @result.varvalue.text_value.should == 'bar'        
      end
      describe "evaluated output" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return a hash of the evaluated string" do
          @evaluated_result.should be_a_kind_of(Hash)          
        end
        it "should be able to lookup the variable name" do
          @evaluated_result['foo'].should eql('bar')          
        end        
      end
      describe "commented out" do
        before(:all) do
          @result = @parser.parse("foo = \"forty-two\" #Answer to Life, the Universe, and Everything\n")
          @evaluated_result = @result.eval({})
        end
        it "should return a hash of the evaluated string" do
          @evaluated_result.should be_a_kind_of(Hash)          
        end
        it "should be able to lookup the variable name" do
          @evaluated_result['foo'].should eql('forty-two')          
        end
      end
    end
  end
end