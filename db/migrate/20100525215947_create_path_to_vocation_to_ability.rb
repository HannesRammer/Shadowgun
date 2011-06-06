class CreatePathToVocationToAbility < ActiveRecord::Migration
  def self.up
    create_table :path_to_vocation_to_abilities do |t|
      t.integer :path_id
      t.integer :vocation_id
      t.integer :ability_id
      t.timestamps

    end
    path_druide = Path.find_by_name("druide")
    path_hueter = Path.find_by_name("hüter")
    vocation_naehren = Vocation.find_by_name("nähren")

    naehren_basic = [
            ["Basis-Schild-Buff","Dünne Borkenhaut ", "armor", 2, 3, 1, "p", 12, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Schwache Borkenhaut ", "armor", 4, 3, 2, "p", 14, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Borkenhaut ", "armor", 6, 3, 2, "p", 16, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Starke Borkenhaut ", "armor", 9, 3, 3, "p", 19, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Dicke Borkenhaut ", "armor", 12, 3, 4, "p", 22, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Gewaltige Borkenhaut ", "armor", 17, 3, 6, "p", 27, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Haut der Rotbuche ", "armor", 21, 3, 7, "p", 31, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Starke Haut der Rotbuche ", "armor", 26, 3, 9, "p", 36, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Dicke Haut der Rotbuche ", "armor", 32, 3, 11, "p", 42, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Schild-Buff","Gewaltige Haut der Rotbuche ", "armor", 45, 3, 16, "p", 55, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Stärke-Buff","Stärke der Eiche ", "body", 3, 3, 1, "p", 12, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Stärke-Buff","Stärke der Rotbuche ", "body", 7, 3, 3, "p", 15, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Stärke-Buff","Sein der Eiche ", "body", 14, 3, 5, "p", 21, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Stärke-Buff","Sein der Rotbuche ", "body", 20, 3, 7, "p", 26, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Stärke-Buff","Kraft der Eiche ", "body", 30, 3, 11, "p", 34, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Stärke-Buff","Kraft der Rotbuche ", "body", 41, 3, 15, "p", 42, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Stärke-Buff","Macht der Rotbuche ", "body", 50, 3, 19, "p", 50, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Konzentration-Buff","Beleibung der Eiche ", "mind", 5, 3, 2, "p", 14, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Konzentration-Buff","Stamina der Eiche ", "mind", 11, 3, 4, "p", 18, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Konzentration-Buff","Umfang der Eiche ", "mind", 15, 3, 5, "p", 22, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Konzentration-Buff","Belebung des Mammutbaums ", "mind", 24, 3, 8, "p", 29, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Konzentration-Buff","Stamnia des Mammutbaums ", "mind", 33, 3, 12, "p", 36, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Konzentration-Buff","Umfang des Mammutbaums ", "mind", 43, 3, 15, "p", 44, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Geschicklichkeits-Buff","Geschicklichkeit des Wiesels ", "agility", 8, 3, 3, "p", 16, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Geschicklichkeits-Buff","Geschicklichkeit des Hasen ", "agility", 13, 3, 5, "p", 20, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Geschicklichkeits-Buff","Geschicklichkeit des Dachses ", "agility", 19, 3, 7, "p", 25, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Geschicklichkeits-Buff","Geschicklichkeit des Luchses ", "agility", 28, 3, 10, "p", 32, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Geschicklichkeits-Buff","Geschicklichkeit des Bären ", "agility", 38, 3, 14, "p", 40, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Basis-Geschicklichkeits-Buff","Geschicklichkeit des Wolf ", "agility", 48, 3, 18, "p", 48, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"]
    ]
    naehren_basic.each do |a|
      aby = Ability.create(:group=>a[0], :name=>a[1], :usage_type=>a[2], :level=>a[3], :timecost=>a[4], :mana_cost=>a[5], :mana_cost_type=>a[6], :factor=>a[7], :factor_type=>a[8], :duration_sec=>a[9], :active_till=>a[10],:active_times=>a[11], :activate=>a[12], :dmg=>a[13], :target=>a[14], :repeat=>a[15], :unique_use=>a[16],:effect_color=>a[17])
      PathToVocationToAbility.create(:path_id=>path_druide.id, :vocation_id=>vocation_naehren.id, :ability_id=>aby.id)
      PathToVocationToAbility.create(:path_id=>path_hueter.id, :vocation_id=>vocation_naehren.id, :ability_id=>aby.id)
    end


    naehren_druide=[
            ["Druide-hit_time-Buff","Angriff des Jägers", "hit_time", 2, "3,5", 1, "p", 8, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-hit_time-Buff","Kampfschlag des Jägers", "hit_time", 10, "3,5", 4, "p", 10, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-hit_time-Buff","Attacke des Jägers", "hit_time", 20, "3,5", 7, "p", 12, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-hit_time-Buff","Druck des Jägers", "hit_time", 30, "3,5", 11, "p", 15, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-hit_time-Buff","Schlag des Jägers", "hit_time", 40, "3,5", 14, "p", 17, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-hit_time-Buff","Überfall des Jägers", "hit_time", 50, "3,5", 19, "p", 20, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Stärke-Buff","Stärke des Baumes", "body", 5, 3, 4, "p", 21, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Stärke-Buff","Stärke des Dickichts", "body", 9, 3, 6, "p", 25, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Stärke-Buff","Stärke der Lichtung", "body", 13, 3, 9, "p", 30, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Stärke-Buff","Stärke des Obstgarten", "body", 18, 3, 12, "p", 36, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Stärke-Buff","Stärke des Waldes", "body", 25, 3, 17, "p", 45, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Stärke-Buff","Stärke des Forstes", "body", 34, 3, 24, "p", 55, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Stärke-Buff","Stärke der Wälder", "body", 44, 3, 32, "p", 67, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Geschick-Buff","Tanz der Brise", "agility", 7, 3, 5, "p", 21, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Geschick-Buff","Tanz der Bö", "agility", 14, 3, 9, "p", 25, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Geschick-Buff","Tanz der Verwirbelung", "agility", 19, 3, 13, "p", 37, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Geschick-Buff","Tanz des Sturmes", "agility", 29, 3, 20, "p", 49, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Geschick-Buff","Tanz des Tornados", "agility", 39, 3, 28, "p", 61, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Geschick-Buff","Tanz des Zephyr", "agility", 49, 3, 36, "p", 73, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Int-Buff","Sicht der Natur", "mind", 11, 3, 4, "p", 21, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Int-Buff","Weisheit der Natur", "mind", 22, 3, 8, "p", 32, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Int-Buff","Scharfsinn der Natur", "mind", 31, 3, 11, "p", 41, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-Int-Buff","Vision der Natur", "mind", 42, 3, 15, "p", 52, "%", 0, nil, nil, "button", 0, "friend", -1, "false","00ff00"],
            ["Druide-resi_heat-Buff","Stärke der Sonne", "resist_heat", 23, 3, 0, "p", 8, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_heat-Buff","Ausdauer der Sonne", "resist_heat", 32, 3, 0, "p", 16, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_heat-Buff","Aura der Sonne", "resist_heat", 43, 3, 0, "p", 24, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_cold-Buff","Wärme des Dachses", "resist_cold", 24, 3, 0, "p", 8, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_cold-Buff","Wärme des Wolfes", "resist_cold", 35, 3, 0, "p", 16, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_cold-Buff","Wärme des Bären", "resist_cold", 45, 3, 0, "p", 24, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_mana-Buff","Erdnähe", "resist_mana", 26, 3, 0, "p", 8, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_mana-Buff","Erdbündnis", "resist_mana", 38, 3, 0, "p", 16, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_mana-Buff","Erdvereinigung", "resist_mana", 48, 3, 0, "p", 24, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Druide-resi_dmg-Buff","Kokon der Natur", "resist_dmg", 47, 2, 3, "p", 90, "%", 1, nil, nil, "button", 0, "friend", 1, "false","00ff00"]
    ]
    naehren_druide.each do |a|
      aby = Ability.create(:group=>a[0], :name=>a[1], :usage_type=>a[2], :level=>a[3], :timecost=>a[4], :mana_cost=>a[5], :mana_cost_type=>a[6], :factor=>a[7], :factor_type=>a[8], :duration_sec=>a[9], :active_till=>a[10],:active_times=>a[11], :activate=>a[12], :dmg=>a[13], :target=>a[14], :repeat=>a[15], :unique_use=>a[16],:effect_color=>a[17])
      PathToVocationToAbility.create(:path_id=>path_druide.id, :vocation_id=>vocation_naehren.id, :ability_id=>aby.id)
    end

    naehren_hueter=[
            ["Hüter-hit_time-Buff","Wildheit der Natur", "hit_time", 3, 3, 15, "%", 16, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-hit_time-Buff","Zorn der Natur", "hit_time", 8, 3, 15, "%", 19, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-hit_time-Buff","Wut der Natur", "hit_time", 13, 3, 15, "%", 21, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-hit_time-Buff","Ärger der Natur", "hit_time", 21, 3, 15, "%", 25, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-hit_time-Buff","Feindseligkeit der Natur", "hit_time", 30, 3, 15, "%", 30, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-hit_time-Buff","Aggression der Natur", "hit_time", 38, 3, 15, "%", 34, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-hit_time-Buff","Auflehnung der Natur", "hit_time", 47, 3, 15, "%", 38, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-reduce_time-Buff","Anhaltender Angriff", "reduce_time", 12, 3, 10, "%", 20, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-reduce_time-Buff","Andauernder Angriff", "reduce_time", 22, 3, 10, "%", 25, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-reduce_time-Buff","Permanenter Angriff", "reduce_time", 32, 3, 10, "%", 30, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-reduce_time-Buff","Ununterbrochener Angriff", "reduce_time", 41, 3, 10, "%", 40, "%", 1200, nil, nil, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-resist_dmg-Buff","Stärke Gesundheit", "resist_dmg", 22, 3, 18, "%", 8, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Hüter-resist_dmg-Buff","Stärke Ausdauer", "resist_dmg", 32, 3, 26, "%", 16, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Hüter-resist_dmg-Buff","Stärke Freundlichkeit", "resist_dmg", 43, 3, 36, "%", 24, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Hüter-resist_mana-Buff","Hüters Mut", "resist_mana", 23, 3, 19, "%", 8, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Hüter-resist_mana-Buff","Hüters Ehre", "resist_mana", 33, 3, 27, "%", 16, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Hüter-resist_mana-Buff","Hüters Geist", "resist_mana", 48, 3, 41, "%", 24, "%", 600, nil, nil, "button", 0, "group", -1, "false","00ff00"],
            ["Hüter-resist_dmg-Buff_2","Schutz der Natur", "resist_dmg", 2, 4, 8, "%", 100, "%", 0, "received_dmg", 1, "button", 0, "self", -1, "false","00ff00"],
            ["Hüter-resist_dmg-Buff_2","Schirm der Natur", "resist_dmg", 10, 4, 8, "%", 100, "%", 0, "received_dmg", 1, "button", 0, "friend", -1, "false","00ff00"],
            ["Hüter-resist_dmg-Buff_2","Schild der Natur", "resist_dmg", 18, 4, 12, "%", 100, "%", 0, "received_dmg", 1, "button", 0, "group", -1, "false","00ff00"],
            ["Hüter-resist_dmg-Song","Wache der Natur", "resist_dmg", 26, 0, 16, "%", 100, "%", 10, "received_dmg", 1, "button", 0, "group", 10, "true","00ff00"],
            ["Hüter-resist_dmg-Song","Sperre der Natur", "resist_dmg", 36, 0, 23, "%", 100, "%", 8, "received_dmg", 1, "button", 0, "group", 8, "true","00ff00"],
            ["Hüter-resist_dmg-Song","Wall der Natur", "resist_dmg", 45, 0, 29, "%", 100, "%", 6, "received_dmg", 1, "button", 0, "group", 6, "true","00ff00"],
            ["Hüter-Geschwindigkeit-Song","Ermutigung des Wächters", "speed", 4, 3, 0, "%", 123, "%", 6, nil, nil, "button", 0, "group", 6, "true","00ff00"],
            ["Hüter-Geschwindigkeit-Song","Ermutigung des Wohltäters", "speed", 15, 3, 0, "%", 131, "%", 6, nil, nil, "button", 0, "group", 6, "true","00ff00"],
            ["Hüter-Geschwindigkeit-Song","Ermutigung des Beschützers", "speed", 24, 3, 0, "%", 138, "%", 6, nil, nil, "button", 0, "group", 6, "true","00ff00"],
            ["Hüter-Geschwindigkeit-Song","Ermutigung des Hüters", "speed", 34, 3, 0, "%", 145, "%", 6, nil, nil, "button", 0, "group", 6, "true","00ff00"],
            ["Hüter-Geschwindigkeit-Song","Ermutigung des Paragons", "speed", 44, 3, 0, "%", 153, "%", 6, nil, nil, "button", 0, "group", 6, "true","00ff00"],
            ["Hüter-Schaden-Song","Rache der Natur", "dmg", 5, 0, 0, "%", 1, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-Schaden-Song","Vendetta der Natur", "dmg", 9, 0, 0, "%", 2, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-Schaden-Song","Blutrache der Natur", "dmg", 14, 0, 0, "%", 3, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-Schaden-Song","Vergeltung der Natur", "dmg", 19, 0, 0, "%", 4, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-Schaden-Song","Strafe der Natur", "dmg", 25, 0, 0, "%", 5, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-Schaden-Song","Fehde der Natur", "dmg", 35, 0, 0, "%", 6, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-Schaden-Song","Abrechnung der Natur", "dmg", 46, 0, 0, "%", 7, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-hit_time-Song","Flinkheit", "hit_time", 18, 0, 6, "%", 24, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-hit_time-Song","Verbesserte Flinkheit", "hit_time", 26, 0, 8, "%", 28, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-hit_time-Song","Verstärkte Flinkheit", "hit_time", 32, 0, 12, "%", 31, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-hit_time-Song","Reine Flinkheit", "hit_time", 44, 0, 15, "%", 37, "%", 5, nil, nil, "button", nil, "group", 8, "true","00ff00"],
            ["Hüter-Heilen-Buff","Kurator der Natur", "heal", 10, 0, 25, "%", 25, "p", 30, nil, 1, "button", nil, "self", 30, "false","00ff00"],
            ["Hüter-Heilen-Buff","Diacon der Natur", "heal", 20, 0, 25, "%", 50, "p", 30, nil, 1, "button", nil, "self", 30, "false","00ff00"],
            ["Hüter-Heilen-Buff","Wächter der Natur", "heal", 30, 0, 25, "%", 75, "p", 30, nil, 1, "button", nil, "self", 30, "false","00ff00"],
            ["Hüter-Heilen-Buff","Steward der Natur", "heal", 40, 0, 25, "%", 100, "p", 30, nil, 1, "button", nil, "self", 30, "false","00ff00"],
            ["Hüter-Heilen-Buff","Bewacher der Natur", "heal", 50, 0, 25, "%", 125, "p", 30, nil, 1, "button", nil, "self", 30, "false","00ff00"]
    ]
    naehren_hueter.each do |a|
      aby = Ability.create(:group=>a[0], :name=>a[1], :usage_type=>a[2], :level=>a[3], :timecost=>a[4], :mana_cost=>a[5], :mana_cost_type=>a[6], :factor=>a[7], :factor_type=>a[8], :duration_sec=>a[9], :active_till=>a[10],:active_times=>a[11], :activate=>a[12], :dmg=>a[13], :target=>a[14], :repeat=>a[15], :unique_use=>a[16],:effect_color=>a[17])
      PathToVocationToAbility.create(:path_id=>path_hueter.id, :vocation_id=>vocation_naehren.id, :ability_id=>aby.id)
    end


  end

  def self.down
    drop_table :path_to_vocation_to_abilities
  end
end
