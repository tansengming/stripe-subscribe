class CreateStripeIds < ActiveRecord::Migration[5.2]
  def change
    create_table :stripe_ids do |t|
      t.string  :stripe_id
      t.string  :stripe_object
      t.integer :stripeable_id
      t.string  :stripeable_type
      t.timestamps
    end

    add_index :stripe_ids, [:stripeable_type, :stripeable_id]
    add_index :stripe_ids, [:stripe_id]
  end
end
