class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :schedule
      t.belongs_to :list, index: true
      t.timestamps
    end
  end
end
