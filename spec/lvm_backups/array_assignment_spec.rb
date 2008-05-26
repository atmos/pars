require File.dirname(__FILE__) + '/../spec_helper'

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end
  describe "to an array" do
    describe "with one element" do
      before(:all) do
        @result = @parser.parse("foo = [\"RESIZEABLE\"]\n")
      end
      it "should return a kind of LvmBackup::AssignemtnOperation" do
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
          @evaluated_result['foo'].should eql(%w(RESIZEABLE))          
        end
      end
      describe "commented out" do
        before(:all) do
          @result = @parser.parse("foo = [\"RESIZEABLE\"] #Answer to Life, the Universe, and Everything\n")
          @evaluated_result = @result.eval({})
        end
        it "should return a hash of the evaluated string" do
          @evaluated_result.should be_a_kind_of(Hash)          
        end
        it "should be able to lookup the variable name" do
          @evaluated_result['foo'].should eql(%w(RESIZEABLE))          
        end
      end
    end
    describe "with more than one element" do
      before(:all) do
        @result = @parser.parse("foo = [\"RESIZEABLE\", \"READ\", \"WRITE\", \"CLUSTERID\"]")
      end
      it "should return a kind of LvmBackup::AssignemtnOperation" do
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
          @evaluated_result['foo'].should eql(%w(RESIZEABLE READ WRITE CLUSTERID))
        end
      end
      
    end
  end
end