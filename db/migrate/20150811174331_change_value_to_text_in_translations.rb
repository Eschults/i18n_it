class ChangeValueToTextInTranslations < ActiveRecord::Migration
  def change
    rename_column :translations, :value, :text
  end
end
