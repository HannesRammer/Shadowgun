class CreateCultureToSubCultures < ActiveRecord::Migration
  def self.up
    create_table(:culture_to_sub_cultures) do |t|
      t.column :culture_id,    :integer
      t.column :sub_culture_id, :integer
    end
    numbers=[[2, 4, 6, 7, 9, 10, 11, 12, 13],
             [2, 4, 6, 9, 10, 11, 12, 13],
             [2, 4, 10, 11, 12, 13],
             [2, 3, 6, 7, 10, 11],
             [2, 3, 7, 10, 11, 12],
             [2, 6, 10, 11, 12, 13],
             [1, 5, 8, 10, 11]]

    numbers.each_with_index do |n, i|
      n.each do |number|
        ctsc=CultureToSubCulture.new()
        ctsc.culture_id = (i + 1)
        ctsc.sub_culture_id = number
        ctsc.save
      end
    end
  end

  def self.down
    drop_table :culture_to_sub_cultures
  end
end


