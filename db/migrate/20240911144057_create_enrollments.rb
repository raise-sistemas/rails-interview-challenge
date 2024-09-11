class CreateEnrollments < ActiveRecord::Migration[7.2]
  def change
    create_table :enrollments do |t|
      t.references :event, null: false, foreign_key: true
      t.string :email

      t.timestamps
    end
  end
end
