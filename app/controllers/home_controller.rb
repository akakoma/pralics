class HomeController < ApplicationController
  before_action :forbid_login_user,{only:[:top]}
  before_action :authenticate_user,{only:[:index]}
  def top
  end

  def index
    @events = Event.all
    @events_reco = Event.order('likes_count desc').limit(4)
    @events_time = Event.order('id desc').limit(4)
    @events_par = Event.where(genre:'パーティー').order('id desc').limit(4)
    @events_trip = Event.where(genre:'旅行').order('id desc').limit(4)
    @events_fit = Event.where(genre:'フィットネス').order('id desc').limit(4)
    @events_sem = Event.where(genre:'セミナー').order('id desc').limit(4)
    @events_other = Event.where(genre:'その他').order('id desc').limit(4)
    @users = User.includes(:usersubgroups).find_by(id: @current_user.id)
    @likes = Like.where(user_id: @current_user.id)
    @attends = Attend.where(user_id: @current_user.id)
    @estaevents = Estaevent.where(user_id: @current_user.id)
    a = Information.where(user_id: @current_user.id)
    b = Information.where(user_id: 0)
    @informations = a + b
  end

  def search
    @join = Group.find_by(
            name: params[:name],
            sub_password: params[:sub_password]
    )
    if @join
      redirect_to("/users/#{@join.name}/join")
    else
      @name = params[:name]
      @sub_password = params[:sub_password]
      @events = Event.all
      @events_reco = Event.order('likes_count desc').limit(4)
      @events_time = Event.order('id desc').limit(4)
      @events_par = Event.where(genre:'パーティー').order('id desc').limit(4)
      @events_trip = Event.where(genre:'旅行').order('id desc').limit(4)
      @events_fit = Event.where(genre:'フィットネス').order('id desc').limit(4)
      @events_sem = Event.where(genre:'セミナー').order('id desc').limit(4)
      @events_other = Event.where(genre:'その他').order('id desc').limit(4)
      @users = User.includes(:usersubgroups).find_by(id: @current_user.id)
      @likes = Like.where(user_id: @current_user.id)
      @attends = Attend.where(user_id: @current_user.id)
      @estaevents = Estaevent.where(user_id: @current_user.id)
      a = Information.where(user_id: @current_user.id)
      b = Information.where(user_id: 0)
      @informations = a + b
      flash.now[:notice] = "団体名またはパスワードが間違っています"
      render('home/index')
    end
  end

end
