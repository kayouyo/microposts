class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :country
      t.string :animal      

      t.timestamps null: false
    
      # unique index 追加: 0616 L6 5.2 マイグレーションの実行
      t.index :email, unique: true
    end
  end
end
