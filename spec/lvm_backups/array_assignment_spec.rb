require File.dirname(__FILE__) + '/../spec_helper'

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end
  describe "to an array" do
    before(:all) do
      @result = @parser.parse('foo = ["RESIZEABLE"]')
      # @result = @parser.parse('foo = ["RESIZEABLE", "READ", "WRITE", "CLUSTERED"]')        

    end
    it "should return a kind of LvmBackup::AssignemtnOperation" do
      @result.should be_a_kind_of(LvmBackup::ArrayListOperation)
    end
    it "should have a varname for the left hand side of the expression" do
      @result.varname.text_value.should == 'foo'        
    end
    it "should have a varvalue for the right hand side of the expression" do
      @result.list.text_value.should == ["RESIZEABLE"]
    end
    
    describe "evaluated output" do
      before(:all) do
        @evaluated_result = @result.eval({})
      end
      it "should return a hash of the evaluated string" do
        @evaluated_result.should be_a_kind_of(Hash)          
      end
      it "should be able to lookup the variable name" do
        # @evaluated_result['foo'].should eql(%w(RESIZEABLE READ WRITE CLUSTERED))
        @evaluated_result['foo'].should eql(%w(RESIZEABLE))          
        
      end
    end
  end
end