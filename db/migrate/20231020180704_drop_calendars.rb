class DropCalendars < ActiveRecord::Migration[7.0]
  def change
   drop_table :calendars 
  end
end
