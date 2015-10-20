json.array! Mdb.all do |f|
  json.file_name f.file_name
  json.file f.file.force_encoding("ISO-8859-1").encode("utf-8")
end
