class CreateCultureToAbilities < ActiveRecord::Migration
  def self.up
    create_table :culture_to_abilities do |t|
      t.column :culture_id, :integer
      t.column :ability_id, :integer
      t.timestamps
    end


    array =[ [1,
              "HÄRTE;ÜBERLEBEN;Wahrnehmung",
              "Einzelgänger;Eremit;Genügsamkeit;Kind des Urvolkes;Sammelwut"],
             [2,
              "Projektilwaffen;Schriftsprache;Selbstbeherrschung;Verhandeln",
              "Lethargie;Rebell;Sucht;Zwei Seiten"],
             [3,
              "Ausdauer;UNBEWAFFNETER NAHKAMPF;HÄRTE;Kraft;Laufen;Überleben;Wahrnehmung",
              "Erdensinn;Genügsamkeit;Schutzinstinkt;Starke Sippe"],
             [4,
              "UNBEWAFFNETER NAHKAMPF;Dominieren;HÄRTE;Initiative;Kraft;Ortskunde",
              "Rachegelüste;Sprunghaft;Stolz;Streitlust;Wildheit"],
             [5,
              "HÄRTE;Initiative;Kraft;Überleben",
              "Fremdenfeindlich;Gefahrensinn;Militarist;Stolz;Wildheit"],
             [6,
              "UNBEWAFFNETER NAHKAMPF;Glauben;Legendenkenntnis;Verstellen;Wurfwaffen",
              "Auserwählt;Fanatismus;Gnadenlos;Rachegelüste;Rebell;Starke Sippe;Tradition"],
             [7,
              "FÜHRUNG;Glauben;Initiative;Verhandeln",
              "Erdensinn;Lebenslust;Rachegelüste;Starke Sippe;Stolz;Tradition"] ]


    array.each_with_index do |culture, t|
      culture[1].split(";").each_with_index do |s, i|
        ca= CultureToAbility.new()
        ab = Ability.find_by_name(s.upcase)
        p s
        ca.ability_id = ab.id
        ca.culture_id = culture[0]
        ca.save
      end

    end
  end

  def self.down
    drop_table :culture_to_abilities
  end
end
