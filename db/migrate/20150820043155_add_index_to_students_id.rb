class AddIndexToStudentsId < ActiveRecord::Migration
  def change
    add_index :students, :id
  end
end
