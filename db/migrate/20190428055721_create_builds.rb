class CreateBuilds < ActiveRecord::Migration[5.1]
  def change
    create_table :builds do |t|
      t.string :uuid, null: false
      t.string :project_uuid, null: false
      t.string :project_id, null: false
      t.string :organization_uuid, null: false
      t.string :ref, null: false
      t.string :commit_sha, null: false
      t.string :status, null: false
      t.string :username, null: false
      t.string :commit_message, null: false
      t.string :branch, null: false
      t.string :pr_number
      t.datetime :finished_at
      t.datetime :allocated_at
      t.datetime :queued_at

      t.timestamps
    end
  end
end
