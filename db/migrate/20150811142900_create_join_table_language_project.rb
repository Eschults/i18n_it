class CreateJoinTableLanguageProject < ActiveRecord::Migration
  def change
    create_join_table :packs, :sources do |t|
      t.index [:pack_id, :source_id]
      t.index [:source_id, :pack_id]
    end
  end
end
