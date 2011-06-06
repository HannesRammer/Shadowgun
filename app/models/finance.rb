class Finance < ActiveRecord::Base

  def self.current_state
    Finance.finance_sum("all")
  end

  def self.finance_sum(type)
    sum = 0
    if type == "all"
      Finance.all.each do |item|
        sum += item.how_much if !item.how_much.blank?
      end
    else
      Finance.find_by_spending_type(type).each do |item|
        sum += item.how_much if !item.how_much.blank?
      end
    end
    return sum
  end

  def current_account
    red = Finance.finance_sum('account-')
    black = Finance.finance_sum('account')
    black += Finance.finance_sum('account+')
  end
end
