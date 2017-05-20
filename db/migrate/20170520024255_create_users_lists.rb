class CreateUsersLists < ActiveRecord::Migration[5.1]
  def change
    create_table :users_lists, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :list, index: true
    end
  end
end
