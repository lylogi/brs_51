class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :cover
      t.string :author_name
      t.date :publish_date
      t.references :category, foreign_key: true
      t.integer :pages
      t.text :description
      t.text :content
      t.float :rate

      t.timestamps
    end
  end
end
