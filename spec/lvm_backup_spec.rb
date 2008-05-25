require File.dirname(__FILE__) + '/spec_helper'

describe LvmBackup, "parsing" do
  it "should do it big like the rappers" do
    parser = LvmBackupParser.new
    pp parser
    if parser.parse("foo = 'bar'")
      pp parser
      puts "success"
    else
      pp parser
      puts "FAIL"
    end
  end
end