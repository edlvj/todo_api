class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.references :user, index: true, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
