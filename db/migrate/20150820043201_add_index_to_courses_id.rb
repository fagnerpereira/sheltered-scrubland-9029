class AddIndexToCoursesId < ActiveRecord::Migration
  def change
    add_index :courses, :id
  end
end
