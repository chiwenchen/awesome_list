class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.jsonb :raw_data
      t.timestamps
    end
  end
end
