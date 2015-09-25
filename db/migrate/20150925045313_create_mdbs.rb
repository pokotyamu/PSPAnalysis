class CreateMdbs < ActiveRecord::Migration
  def change
    create_table :mdbs do |t|
      t.string :file_name
      t.binary :file

      t.timestamps null: false
    end
  end
end
