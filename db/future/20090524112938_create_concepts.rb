class CreateConcepts < ActiveRecord::Migration
  def self.up
    create_table :concepts do |t|
      t.column :name,    :string, :null => false
      t.column :bonis,    :string, :null => false
      t.column :principles,    :string, :null => false
      t.timestamps
    end




    array =[["Schmerz",
             "+1,Beweglichkeit",
             "Gebranntes Kind;Gnadenlos;Lethargie"],
            ["Wahn",
             "+1,Psyche",
             "Fanatismus;Selbstkasteiung;Sternenangst"],
            ["Eintracht",
             "+1,Ausstrahlung",
             "Bindeglied;Elitedenken;Moralist;Reinheit" ],
            ["Zwang",
             "+1,Psyche",
             "Denunziant;Einzelgänger;Elitedenken;Fremdenhass;Paranoia"],
            ["Quarantäne",
             "+1,Körper",
             "Einzelgänger;Elitedenken;Fanatismus;Genügsamkeit"],
            ["Verfall",
             "+1,Körper",
             "Lethargie;Masochist;Opportunist;Rebell;Sadist"],
            ["Begierde",
             "+1,Ausstrahlung",
             "Dekadenz;Selbstzerstörung;Sucht;Spieler;Verschwendung"],
            ["Reichtum",
             "+1,Verstand",
             "Arroganz;Elitedenken;Gier;Status ausleben"]]

    array.each_with_index do |concept, t|
      c = Concept.new()
      c.name = concept[0]
      c.bonis = concept[1]

      c.principles = concept[2]
      c.save


    end
  end

  def self.down
    drop_table :concepts
  end
end
