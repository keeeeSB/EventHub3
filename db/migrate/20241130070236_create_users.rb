class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :profile_image
      t.text :bio
      t.string :activation_token
      t.boolean :activated, default: false
      t.string :ctivated_atdatetime

      t.timestamps
    end
  end
end
