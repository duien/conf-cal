class CreatePresentations < ActiveRecord::Migration
  def self.up
    create_table :presentations do |t|
      t.string :summary
      t.string :uid, :unique => true
      t.text   :description
      t.string :location
      t.string :presenters
      t.datetime :start_time
      t.datetime :end_time
    end
  end

  def self.down
    drop_table :presentations
  end
end
