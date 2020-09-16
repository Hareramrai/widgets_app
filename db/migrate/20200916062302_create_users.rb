class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: true
      t.string :image_url
      t.boolean :active
      t.string :access_token
      t.integer :expires_in
      t.string :refresh_token
      t.integer :widget_user_id

      t.timestamps
    end
  end
end
