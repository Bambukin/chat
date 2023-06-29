class AddColumnToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :connections, :integer, default: 0
  end
end
