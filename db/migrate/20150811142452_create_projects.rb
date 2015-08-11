class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :company, index: true, foreign_key: true
      t.string :project_name

      t.timestamps null: false
    end
  end
end
