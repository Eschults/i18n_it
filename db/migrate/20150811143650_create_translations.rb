class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :translation_key
      t.text :value
      t.references :bucket, index: true, foreign_key: true
      t.references :sub_bucket, index: true, foreign_key: true
      t.references :language, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
