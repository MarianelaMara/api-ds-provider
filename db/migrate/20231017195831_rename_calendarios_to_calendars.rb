class RenameCalendariosToCalendars < ActiveRecord::Migration[7.0]
  def change
    rename_table :calendarios, :calendars
  end
end
