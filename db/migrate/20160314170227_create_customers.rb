class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :email
      t.string :name
      t.text :comment
    end
  end
end
