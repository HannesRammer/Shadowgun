class AccountsController < ApplicationController

  
  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(params[:account])
    if @account.save
       msg = "Thank you for signing up! You are now logged in. User generiert"
       msg << Character.generate_character(@account)
      session[:account_id] = @account.id
      flash[:notice] =
      redirect_to :controller => :administration, :action=>:start
    else
      render :action => 'new'
    end
  end
end
