class ChangeColumnStatusForCourses < ActiveRecord::Migration
  def change
    change_column :courses, :status, :boolean, default: true
  end
end
