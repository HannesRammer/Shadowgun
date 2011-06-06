class DialogSet < ActiveRecord::Base
  def self.set_dialog(user_char_id,pc_char_id, dialog_set_id)
    if set = self.find_by_user_char_id_and_pc_char_id(user_char_id,pc_char_id)
      set.update_attributes(:user_char_id=>user_char_id, :pc_char_id=>pc_char_id, :set_id=> dialog_set_id)
    else
      self.create(:user_char_id=>user_char_id, :pc_char_id=>pc_char_id, :set_id=> dialog_set_id )
    end
  end
  def self.destroy_user_dialog(user_char_id,pc_char_id)
    ds = DialogSet.find_by_user_char_id_and_pc_char_id(user_char_id, pc_char_id)
    ds && ds.destroy
  end
end
