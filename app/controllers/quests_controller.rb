class QuestsController < ApplicationController
  before_filter :login_required

  def load_dialog(new_set_id)
    @pc = Character.find_by_id(params[:pc_char_id])
    set_id = new_set_id
    @pc.dialog(@current_char.id, set_id)
  end

  def index
    @quests = Quest.all
  end

  def show
    @quest = Quest.find(params[:id])
  end

  def new
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(params[:quest])
    if @quest.save
      flash[:notice] = "Successfully created quest."
      redirect_to @quest
    else
      render :action => 'new'
    end
  end

  def edit
    @quest = Quest.find(params[:id])
  end

  def update
    @quest = Quest.find(params[:id])
    if @quest.update_attributes(params[:quest])
      flash[:notice] = "Successfully updated quest."
      redirect_to @quest
    else
      render :action => 'edit'
    end
  end

  def destroy
    @quest = Quest.find(params[:id])
    @quest.destroy
    flash[:notice] = "Successfully destroyed quest."
    redirect_to quests_url
  end

  def start_quest
    new_set_id = params[:new_set_id].to_i
    text = @current_char.add_quest(params[:quest_id])
    @current_char.update_dialog(params[:pc_char_id], new_set_id)
    dialog = load_dialog(new_set_id)
    render :update do |page|
      bubble_render(page,@pc,@current_char,dialog)
      page["notice"].replace_html text
    end

  end

  def increase_quest_step
    quest_id = params[:quest_id].to_i / 1000
    quest_nr = params[:quest_id].to_i
    new_set_id = params[:new_set_id].to_i
    char_quest_id = @current_char.unique_quest_id(quest_nr)
    ok_to_increase = nil
    #update_quest
    eval "ok_to_increase = Quest::Quest#{quest_id}.update_for_user(#{@current_char.id})"
    if ok_to_increase
      new_status = Quest.status_for_user_char(params[:user_id].to_i, char_quest_id) + 1
      text = Quest.set_status_for_user_char(char_quest_id, params[:user_id].to_i, new_status)
    else
      new_set_id = "#{quest_id}999"
    end
    dialog = load_dialog(new_set_id)
    render :update do |page|
      bubble_render(page,@pc,@current_char,dialog)
      page["notice"].replace_html text if text
    end
  end

  def end_quest
    quest_id = params[:quest_id].to_i / 1000
    quest_nr = params[:quest_id].to_i
    new_set_id = params[:new_set_id].to_i
    char_quest_id = @current_char.unique_quest_id(quest_nr)
    text = eval "Quest::Quest#{quest_id}.end_for_user(#{@current_char.id})"

    new_status = Quest.status_for_user_char(params[:user_id].to_i, char_quest_id) + 1
    text << Quest.set_status_for_user_char(char_quest_id, params[:user_id].to_i, new_status)
    dialog = load_dialog(new_set_id)
    render :update do |page|
      bubble_render(page,@pc,@current_char,dialog)
      page["notice"].replace_html text
      page["music"].replace_html javascript_tag("window.location=window.location+'#{"?level_up=true" if text.include?("level up")}';")
    end
  end

end
