class AddBirthdateToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birthdate, :date
  end
end
