class RemoveColumnFromParticipants < ActiveRecord::Migration[7.0]
  def change
    remove_column :participants, :connections
  end
end
