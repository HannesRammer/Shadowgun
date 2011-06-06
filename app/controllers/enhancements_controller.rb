class EnhancementsController < ApplicationController
  before_filter :login_required

  def body
    @body_enhancements=["enhancements/body/female_unmod.png"]
    @enhancer = Character.find_by_name('THE ENHANCER')
    x = params[:level].to_i || 0
    %w{female}.each do |sex|
      BodyPart.find_all_by_version(x).each do |bp|
        @body_enhancements << bp
      end
    end
    if request.post?
      render :update do |page|
        page["body_enhancement_dealer"].replace :partial=>"body_enhancement_dealer"
      end
    end
  end

  def enhance
    bp = BodyPart.find_by_id(params[:body_part_id])
    user = Character.find_by_id(params[:user_char])
    enhancer = Character.find_by_id(params[:pc_char])
    exchange = user.exchange_money_to(enhancer, bp.buy_price_for(user))
    enhanced = user.has_enhancement?(bp.id)
    if exchange && !enhanced
      old_part = user.enhancment(bp.name)
      CharacterToBodyPart.find_by_body_part_id_and_character_id(old_part, user.id).destroy  if old_part
      user.body_parts << bp
      render :update do |page| #:juggernaut => {:type => :send_to_channels, :channels => [user.account_id.to_s]} do |page|
        @trader = enhancer
        @char = user
        page["notice"].replace_html "du wurdest enhanced"
      end
      # render :nothing => true
    elsif !exchange
      ok("nicht genug gold")
    elsif enhanced
      ok("hast du soch schon .. 2 mal hilft auch nich besser")
    end
  end


end
