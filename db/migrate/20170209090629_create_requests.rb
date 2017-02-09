class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :title
      t.date :publish_date
      t.string :author_name
      t.integer :pages
      t.references :user, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
