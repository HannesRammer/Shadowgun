class PreloadQuest2 < ActiveRecord::Migration
  def self.up
    quest2 = [[2000, "wow du kommst gut vorran!", "trader", nil, ""],
              [2000, "danke, findest du?", "user", 2001, ""],
              [2001, "klar, wenn du so weiter machst wird noch was aus dir", "trader", nil, ""],
              [2001, "lust auf ne quest, wirst es nicht bereuen", "trader", nil, ""],
              [2001, "hmm, ja ok.", "quest", 2010, "start_quest"],
              [2001, "nee heute nicht.", "user", -1, ""],
              [2010, "und? schon glück gehabt??", "trader", -1, ""],
              [2010, "na klar!", "quest", 2011, "increase_quest_step"],
              [2010, "nein", "user", -1, ""],
              [2011, "gut also hast du schonmal von bodyenhancements gehört? nicht?", "trader", nil, ""],
              [2011, "schau einfach in meinem shop vorbei und ich erklär dir alles", "trader", nil, ""],
              [2011, "cool na dann viel spaß noch ;) *mit der dummen kuh*", "quest", -1, "end_quest"]]

    quest2.each do |a|
      d = Dialog.create()
      d.set_id = a[0]
      d.text = a[1]
      d.dialog_type = a[2]
      d.next_set_id = a[3]
      d.action = a[4]
      d.save
    end
    Quest::Quest2.first_time_initiate

  end


end
