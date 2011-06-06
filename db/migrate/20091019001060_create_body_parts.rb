class CreateBodyParts < ActiveRecord::Migration
  def self.up
    create_table :body_parts do |t|
      t.string :name
      t.text :description
      t.float :multi
      t.float :level
      t.float :version
      t.float :worth
    end
    [["arms", "Replacement metal arms. Servo assisted hydraulics allow the carrying of heavier items.", 1.3, 15, 1, 2500],
     ["legs", "Replacement metal legs. Servo assisted hydraulics allow quicker movement.", 1.3, 15, 1, 3000],
     ["chest", "Metal chest cage. All internal organs are shielded by heavy metal casing.", 1.3, 15, 1, 5000],
     ["eyes", "Vision enhancer with limited zoom facility. Allows near perfect sight even at night.", 1.3, 15, 1, 2000],
     ["heart", "Heart stimulator. Monitors and maintains the heart rate of the individual.", 1.3, 15, 1, 4000],
     ["brain", "Neural enhancer that speeds up brain stem response time.", 1.3, 15, 1, 4500],
     ["arms", "Plasteel arms. Lighter and tougher than metal arms. Enhanced hydraulic system and pressure control.", 1.6, 45, 2, 25000],
     ["legs", "Plasteel legs. Lighter and tougher than metal legs. Enhanced hydraulic system and balance control.", 1.6, 45, 2, 30000],
     ["chest", "Plasteel chest cage. Lighter and tougher than the metal version with better mobility.", 1.6, 45, 2, 50000],
     ["eyes", "Enhanced model of the v1 incorporating a target aquisition facility and range finder.", 1.6, 45, 2, 20000],
     ["heart", "Heart accelerator and monitor. Heart rate is almost doubled allowing the quicker distribution of hormones.", 1.6, 45, 2, 40000],
     ["brain", "Neuro CNS device that intercepts most low level functions leaving the brain free to deal with high end desicions.", 1.6, 45, 2, 45000],
     ["arms", "Cybermesh arms. Plasteel core with synthetic muscle fibre. Excellent tactile control and weight loading.", 1.9, 75, 3, 250000],
     ["legs", "Cybermesh legs. Plasteel core with synthetic muscle fibre. Superb response and balance coupled with high speed.", 1.9, 75, 3, 300000],
     ["chest", "Cybermesh chest cage with power shielding. All internal organs are shielded by a low power field generator.", 1.9, 75, 3, 500000],
     ["eyes", "Latest neurocybernetic implants. Gives perfect night vision with the aid of targeters range finders and threat identifier.", 1.9, 75, 3, 200000],
     ["heart", "Powerful pump with in built system analysis and overide facilities. Triples output of a standard human heart.", 1.9, 75, 3, 400000],
     ["brain", "Cerebral multiplier. Connected to a compunet giving access to a mass of tactical info. Adapted from the military version.", 1.9, 75, 3, 450000]].each do |bp|
      b=BodyPart.new()
      b.name =bp[0]
      b.description=bp[1]
      b.multi=bp[2]
      b.level=bp[3]
      b.version=bp[4]
      b.worth=bp[5]
      b.save
    end


  end

  def self.down
    drop_table :body_parts
  end

  
end
