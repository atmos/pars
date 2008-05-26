require File.dirname(__FILE__) + '/../spec_helper'

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end
  describe "multiline input" do
    before(:all) do
      @result = @parser.parse("foo = 42\nbar = 43\n")
    end
    it "shouldn't be nil" do
      @result.should_not be_nil
    end
    it "should return a kind of LvmBackup::AssignemtnOperation" do
      @result.should be_a_kind_of(Treetop::Runtime::SyntaxNode)
    end
    # it "should have a varname for the left hand side of the expression" do
    #   @result.varname.text_value.should == 'foo'        
    # end
    # it "should have a varvalue for the right hand side of the expression" do
    #   @result.varvalue.text_value.should == '42'        
    # end
    describe "evaluated output" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should return a hash of the evaluated string" do
        @evaluated_result.should be_a_kind_of(Hash)          
      end
      it "should be able to lookup the variable name" do
        @evaluated_result['foo'].should eql('42')          
      end
    end
  end
end