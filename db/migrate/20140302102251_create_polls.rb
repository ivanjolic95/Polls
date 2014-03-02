class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :question
      t.boolean :visible

      t.timestamps
    end
  end
end
