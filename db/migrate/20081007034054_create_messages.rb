class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.text :title
      t.timestamps
      t.references :user, :null => false
    end
  end

  def self.down
    drop_table :messages
  end
end
