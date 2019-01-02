class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string   :title, null: false
      t.boolean  :done, default: false
      t.integer  :priority
      t.datetime :deadline
      t.references :project, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
