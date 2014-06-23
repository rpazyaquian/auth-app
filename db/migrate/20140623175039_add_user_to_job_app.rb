class AddUserToJobApp < ActiveRecord::Migration
  def change
    add_reference :job_apps, :user, index: true
  end
end
