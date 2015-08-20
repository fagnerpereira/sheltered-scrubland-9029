class ChangeColumnStatusForStudents < ActiveRecord::Migration
  def change
    change_column :students, :status, :boolean, default: true
  end
end
