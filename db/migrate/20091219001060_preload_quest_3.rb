class PreloadQuest3 < ActiveRecord::Migration
  def self.up
    quest_item1 = {"name"=>"Goldenes Klopapier",
                  "level"=>4,
                  "description"=>"GOLDEN  AND SHITY",
                  "active"=>true}
    quest_item2 = {"name"=>"Heiliges Abführmittel",
                  "level"=>3,
                  "description"=>"GOLDEN  AND SHITY",
                  "active"=>true}
    quest3 = [[3000, "hast du goldenes klopapier?!", "trader", nil, ""],
              [3000, "bitte was?", "user", 3001, ""],
              [3001, "na goldenes klopapier. mein freund pipi hat verstopfung und er bräuchte das ganz dringend.", "trader", nil, ""],
              [3001, "besorg mit welches und du wirst gut belohnt", "trader", nil, ""],
              [3001, "hmm, ja ok. (einfach nicken und lächeln, nicken und lächeln)", "quest", 3010, "start_quest"],
              [3001, "nee heute nicht... (kranker typ)", "user", -1, ""],
              [3010, "und? schon glück gehabt??", "trader", -1, ""],
              [3010, "na klar!", "quest", 3011, "increase_quest_step"],
              [3010, "nein", "user", -1, ""],
              [3011, "cool wo hast dus gefunden, ach egal hier für dich!", "trader", nil, ""],
              [3011, "danke (was für kranke leute)", "quest", -1, "end_quest"]]
    Item.create(quest_item1)
    Item.create(quest_item2)
    quest3.each do |a|
      d = Dialog.create()
      d.set_id = a[0]
      d.text = a[1]
      d.dialog_type = a[2]
      d.next_set_id = a[3]
      d.action = a[4]
      d.save
    end
    Quest::Quest3.first_time_initiate

  end


end
