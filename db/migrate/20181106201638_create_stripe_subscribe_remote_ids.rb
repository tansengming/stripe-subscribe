class CreateStripeSubscribeRemoteIds < ActiveRecord::Migration[5.2]
  def change
    create_table :stripe_subscribe_remote_ids do |t|
      t.string  :remote_id
      t.string  :remote_object
      t.integer :stripeable_id
      t.string  :stripeable_type
      t.timestamps
    end

    add_index :stripe_subscribe_remote_ids, [:stripeable_type, :stripeable_id], name: 'index_remote_ids_on_stripeable_type_and_stripeable_id'
    add_index :stripe_subscribe_remote_ids, [:remote_id]
  end
end
