class Mdb < ActiveRecord::Base
  def self.import(file)
    mdb = Mdb.new
    mdb.file_name = file.original_filename
    mdb.file = file.read
    mdb.save if File.extname(mdb.file_name) == ".mdb"
  end
end
