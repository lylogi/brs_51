class CreateReadingStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :reading_statuses do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :status
      t.boolean :is_favorite, default: 0, null: false

      t.timestamps
    end
    add_index :reading_statuses, [:book_id, :user_id], unique:true
  end
end
