class CreateJobApps < ActiveRecord::Migration
  def change
    create_table :job_apps do |t|
      t.string :title
      t.string :description
      t.string :company
      t.date :submission_date

      t.timestamps
    end
  end
end
