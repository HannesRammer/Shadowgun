class PreloadQuest1 < ActiveRecord::Migration
  def self.up
    quest1 = [[1000, "willst ne quest?", "trader", nil, ""],
              [1000, "was muß ich tun?!!", "user", 1001, ""],
              [1000, "neee, heut nich", "user", -1, ""],
              [1001, "such meine freunid susi und sag ihr das ich sie suche", "trader", nil, ""],
              [1001, "hmm, ja ok.", "quest", 1010, "start_quest"],
              [1001, "nee tz zu billig, such selber.", "user", -1, ""],
              [1010, "und? schon gefunden??", "trader", -1, ""],
              [1011, "bist du susi", "user", 1012, ""],
              [1012, "wow kannst ja lesen", "trader", nil, ""],
              [1012, "gut dein freund sucht dich", "quest", 1013, "increase_quest_step"],
              [1013, "ok danke", "trader", -1, ""],
              [1014, "und was neues?", "quest", 1015, "end_quest"],
              [1015, "hey danke, hat mich gesprochen", "trader", nil, ""],
              [1015, "hmm.. hier kannst dafür mein messer haben, hab ja ne freundin", "trader", nil, ""],
              [1015, "cool na dann viel spaß noch ;) *mit der dummen kuh*", "user", -1, ""]]

    quest1.each do |a|


      d = Dialog.create()
      d.set_id = a[0]
      d.text = a[1]
      d.dialog_type = a[2]
      d.next_set_id = a[3]
      d.action = a[4]
      d.save
    end
    Quest::Quest1.first_time_initiate

  end


end
