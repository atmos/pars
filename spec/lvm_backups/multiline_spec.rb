require File.dirname(__FILE__) + '/../spec_helper'

# describe LvmBackup, "parsing" do
#   before(:all) do
#     @parser = LvmBackupParser.new
#   end
#   describe "multiline input" do
#     before(:all) do
#       @result = @parser.parse("foo = 42\n\nbar = 43\nbaz { i = 0 }\n# end config\n")
#     end
#     it "shouldn't be nil" do
#       @result.should_not be_nil
#     end
#     it "should return a kind of LvmBackup::AssignemtnOperation" do
#       @result.should be_a_kind_of(LvmBackup::FileContents)
#     end
# 
#     describe "evaluated output" do
#       before(:all) do
#         @evaluated_result = @result.eval({})
#       end
#       it "should return a hash of the evaluated string" do
#         @evaluated_result.should be_a_kind_of(Hash)          
#       end
#       it "should be able to lookup the variable name" do
#         @evaluated_result['foo'].should eql('42')          
#       end
#       it "should be able to lookup the variable name" do
#         @evaluated_result['bar'].should eql('43')          
#       end
#       it "should be able to lookup the variable name" do
#         @evaluated_result['baz']['i'].should eql('0')          
#       end
#     end
#   end
# end

describe LvmBackup, "parsing" do
  before(:all) do
    @parser = LvmBackupParser.new
  end
  describe "multiline input" do
# Generated by LVM2: Thu May  1 21:01:17 2008\n\ncontents = \"Text Format Volume Group\"\nversion = 1\n"    
    before(:all) do
      str =<<-EOF
# Generated by LVM2: Thu May  1 21:01:17 2008

contents = "Text Format Volume Group"
version = 1

ey04-data00 { 
  id = 4
  version = 1234
}
EOF
      @result = @parser.parse(str)
      # pp @parser
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
      it "should be able to lookup the variable named version" do
        @evaluated_result['version'].should eql(1)          
      end
      it "should be able to lookup the variable named contents" do
        @evaluated_result['contents'].should eql('Text Format Volume Group')
      end
    end
  end
end