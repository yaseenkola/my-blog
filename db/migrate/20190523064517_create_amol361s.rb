class CreateAmol361s < ActiveRecord::Migration[5.1]
  def change
    create_table :amol361s do |t|
      
      t.date :date
			t.text :description
			t.decimal :amount
			t.decimal :discount
			t.decimal :paid
			t.decimal :balance, precision: 10, scale: 2
			t.string :delndel
			t.string :remark
			t.boolean :hidden, :default => false

      t.timestamps
    end
  end
end
