class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:id])
    if @current_user
      a = Information.where(user_id: @current_user.id)
      b = Information.where(user_id: 0)
      @top_information = a + b
    end
  end

  def authenticate_user
    if @current_user == nil
      redirect_to("/pralics")
    end
  end

  def forbid_login_user
    if @current_user
      redirect_to("/pralics/index")
    end
  end

  def forbid_login_company
    if @current_company
      redirect_to("/companies/index")
    end
  end

  def set_current_company
    @current_company = Company.find_by(id: session[:company_id])
  end


  def authenticate_company
    if @current_company == nil
    redirect_to('/companies/login')
    end
  end

  def set_current_manager
    @current_manager = Manager.find_by(id: session[:manager_id])
  end

  def authenticate_manager
    if @current_manager == nil
    redirect_to('/managers/login')
    end
  end

  def forbid_login_manager
    if @current_manager
      redirect_to("/managers/index")
    end
  end

  def forbid_login_group
    if @current_group
      redirect_to("/groups/index")
    end
  end

  def set_current_group
    @current_group = Group.find_by(id: session[:group_id])
  end


  def authenticate_group
    if @current_group == nil
    redirect_to('/groups/login')
    end
  end

end
