class AddStateToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :state, :string
  end
end
