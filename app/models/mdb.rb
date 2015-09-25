class Mdb < ActiveRecord::Base
  def self.import(file)
    mdb = Mdb.new
    mdb.file_name = file.original_filename
    mdb.file = file.read
    mdb.save
  end
end
