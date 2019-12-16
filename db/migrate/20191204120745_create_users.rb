class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :slack_id
      t.string :github_id
      t.string :nickname
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :slack_image
      t.string :auth_token
      t.boolean :is_admin
      t.boolean :is_enterable_library
      t.integer :repeat_year

      t.timestamps
    end
  end
end
