class AddCategoryIdToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_reference :repositories, :category, index: true, foreign_key: true
  end
end
