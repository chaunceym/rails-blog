class AddLogoToEvents < ActiveRecord::Migration[6.0]
  def change
    add_attachment :events, :logo
  end
end
