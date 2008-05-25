require File.dirname(__FILE__) + '/spec_helper'

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

  describe "blocks" do
    describe "simple" do
      before(:all) do
        @result = @parser.parse('foo { bar }')
      end
      it "should return a non nil result" do
        @result.should_not be_nil      
      end
      it "should return a kind of LvmBackup::BlockOperation" do
        @result.should be_a_kind_of(LvmBackup::BlockOperation)      
      end
      it "should have block_contents that are a LvmBackup::StringLiteral" do
        @result.block_contents.should be_a_kind_of(LvmBackup::StringLiteral)      
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
        @result = @parser.parse('foo { bar { baz = 42 } }')
      end
      it "should return a non nil result" do
        @result.should_not be_nil
      end
      it "should return a kind of LvmBackup::BlockOperation" do
        @result.should be_a_kind_of(LvmBackup::BlockOperation)      
      end
      it "should have block_contents that are a LvmBackup::BlockOperation" do
        @result.block_contents.should be_a_kind_of(LvmBackup::BlockOperation)
      end
      describe "evaluated output" do
        before(:all) do
          @evaluated_result = @result.eval({})
        end
        it "should return a hash of attributes" do
          @evaluated_result.should be_a_kind_of(Hash)
        end
        it "should have a value for the parsed block name" do
          @evaluated_result['foo']['bar']['baz'].should eql('42')
        end
      end
    end
  end

  describe "assignment" do
    describe "to a quoted string" do
      before(:all) do
        @result = @parser.parse('foo = "bar"')        
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
    end
    describe "to a integer" do
      before(:all) do
        @result = @parser.parse('foo = 42')        
      end
      it "should return a kind of LvmBackup::AssignemtnOperation" do
        @result.should be_a_kind_of(LvmBackup::AssignmentOperation)        
      end
      it "should have a varname for the left hand side of the expression" do
        @result.varname.text_value.should == 'foo'        
      end
      it "should have a varvalue for the right hand side of the expression" do
        @result.varvalue.text_value.should == '42'        
      end
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
end