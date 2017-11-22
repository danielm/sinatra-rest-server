# db/migrate/20170820014906_rest_entities.rb

class RestEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :texts do |t|
      t.string :name, :null => false
      t.string :message

      t.timestamps
    end
  end
end