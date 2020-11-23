class AddNameToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :name, :string, index: true
  end
end
