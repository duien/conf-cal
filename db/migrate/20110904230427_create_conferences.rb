class Conference < ActiveRecord::Base; end

class CreateConferences < ActiveRecord::Migration
  def self.up
    create_table :conferences do |t|
      t.string :name

      t.timestamps
    end

    Conference.create(:name => 'RubyConf 2010')

  end

  def self.down
    drop_table :conferences
  end
end
