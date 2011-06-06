class CreateConceptToAbilities < ActiveRecord::Migration
  def self.up
    create_table :concept_to_abilities do |t|
      t.column :concept_id,    :string, :null => false
      t.column :ability_id,    :string, :null => false
      t.timestamps
    end




    array =[[1, "Ausdauer;HÄRTE;Initiative",
             "Gebranntes Kind;Gnadenlos;Lethargie"],
            [2,
             "Dominieren;Glauben;Selbstbeherrschung",
             "Fanatismus;Selbstkasteiung;Sternenangst"],
            [3,
             "Geisteskunde;Lebenskunde;Schriftsprache;Verhandeln;Zahlenkunde",
             "Bindeglied;Elitedenken;Moralist;Reinheit" ],
            [4,
             "Dominieren;Selbstbeherrschung;Umgang;Verbergen",
             "Denunziant;Einzelgänger;Elitedenken;Fremdenhass;Paranoia"],
            [5,
             "Dominieren;HÄRTE;ÜBERLEBEN",
             "Einzelgänger;Elitedenken;Fanatismus;Genügsamkeit"],
            [6,
             "HÄRTE;Verbergen",
             "Lethargie;Masochist;Opportunist;Rebell;Sadist"],
            [7,
             "GLÜCKSSPIEL;Stehlen;Verbergen;VERFÜHREN",
             "Dekadenz;Selbstzerstörung;Sucht;Spieler;Verschwendung"],
            [8,
             "FÜHRUNG;Technik;Verhandeln;Zahlenkunde",
             "Arroganz;Elitedenken;Gier;Status ausleben"]]

    array.each_with_index do |concept, t|
      concept[1].split(";").each_with_index do |s, i|
        ca= ConceptToAbility.new()
        ab = Ability.find_by_name(s.upcase)
        ca.ability_id = ab.id
        ca.concept_id = concept[0]
        ca.save
      end

    end
  end

  def self.down
    drop_table :concept_to_abilities
  end
end
