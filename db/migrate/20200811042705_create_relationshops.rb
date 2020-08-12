class CreateRelationshops < ActiveRecord::Migration[6.0]
  def change
    create_table :relationshops do |t|

      t.timestamps
    end
  end
end
