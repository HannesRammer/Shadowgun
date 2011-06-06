class CreateCultures < ActiveRecord::Migration
  def self.up
    create_table :cultures do |t|
      t.column :name,    :string, :null => false
      t.column :bonis,    :string, :null => false
      t.column :principles,    :string, :null => false

      t.timestamps
    end



    array =[ ["BORCA",
              "+1,Verstand;+1,Psyche",
              "Einzelgänger;Eremit;Genügsamkeit;Kind des Urvolkes;Sammelwut"],
             ["FRANKA",
              "+1,Psyche;+1,Ausstrahlung",
              "Lethargie;Rebell;Sucht;Zwei Seiten"],
             ["POLLEN",
              "+1,Psyche;+1,Körper",
              "Erdensinn;Genügsamkeit;Schutzinstinkt;Starke Sippe"],
             ["BALKHAN",
              "+1,Körper;+1,Ausstrahlung",
              "Rachegelüste;Sprunghaft;Stolz;Streitlust;Wildheit"],
             ["HYBRISPANIA",
              "+1,Ausstrahlung;+1,Beweglichkeit",
              "Fremdenfeindlich;Gefahrensinn;Militarist;Stolz;Wildheit"],
             ["PURGARE",
              "+1,Beweglichkeit;+1,Verstand",
              "Auserwählt;Fanatismus;Gnadenlos;Rachegelüste;Rebell;Starke Sippe;Tradition"],
             ["AFRICA",
              "+1,Beweglichkeit;+1,Körper",
              "Erdensinn;Lebenslust;Rachegelüste;Starke Sippe;Stolz;Tradition"] ]

    array.each do |culture|
      c = Culture.new()
      c.name = culture[0]
      c.bonis = culture[1]
      c.principles = culture[2]
      c.save
    end

  end

  def self.down
    drop_table :cultures
  end
end

