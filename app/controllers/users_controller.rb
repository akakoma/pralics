class UsersController < ApplicationController
  before_action :authenticate_user,{only:[:join,:edit,:email_edit,:password_edit,:user_id_edit,
    :image_edit,:organizer,:informations,:information_about,:organizer_contact,:like_create,
    :like_destroy,:appsubgroup_create,:appsubgroup_destroy,:account_destroy
    ]}
  before_action :forbid_login_user,{only:[:login,:signup,:login_system]}

  def login

  end

  def signup
    @user = User.new
  end

  def join
    @group = Group.find_by(name: params[:name])
  end

  def info
    @user = User.find_by(id: params[:id])
    @events = Event.where(organizer_id: @user.organizer_id)
  end

  def edit
    @user = User.find_by(id: params[:id])
    if params[:user_id]
      @user.user_id = params[:user_id]
    end
    if params[:email]
      @user.email = params[:email]
    end
    if params[:image]
      @user.image = "#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/user_images/#{@user.image}", image.read)
    end
    if @user.password == params[:password] && params[:new_password]
      @user.password = params[:new_password]
    end
      @user.save
      redirect_to("/users/#{@user.id}/info")
  end

  def email_edit
    @user = User.find_by(id: params[:id])
  end

  def password_edit
    @user = User.find_by(id: params[:id])
  end

  def user_id_edit
    @user = User.find_by(id: params[:id])
  end

  def image_edit
    @user = User.find_by(id: params[:id])
  end

  def image
    @user = User.find_by(id: params[:id])
  end

  def organizer
    @user = User.find_by(id: params[:id])
  end

  def informations
    @informations = Information.all.order("id DESC")
    a = Information.where(user_id: @current_user.id)
    b = Information.where(user_id: 0)
    @current_user.user_info = a.length + b.length
    @current_user.save
  end

  def information_about
    @information = Information.find_by(id: params[:id])
    if @information.user_id != 0
      @user = User.find_by(id: @information.user_id)
      if @user == nil
          redirect_to('/pralics')
      end
    end
  end

  def organizer_contact
    @user = User.find_by(id: params[:id])
    @contact = Contact.create(
      title: "主催者申請",
      name: @user.name,
      email: @user.email,
      reply: 'not',
      message: '早急にメールで返信してください。'
    )
    redirect_to('/users/organizer/thanks')
  end


  def like_create
    @like = Like.new(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @like.save
    @event = Event.find_by(id: params[:event_id])
    @event.likes_count += 1
    @event.save
    @user = User.find_by(organizer_id: @event.organizer_id)
    redirect_to("/users/#{@user.id}/info")
  end

  def like_destroy
    @like = Like.find_by(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @like.destroy
    @event = Event.find_by(id: params[:event_id])
    @event.likes_count += 1
    @event.save
    @user = User.find_by(organizer_id: @event.organizer_id)
    redirect_to("/users/#{@user.id}/info")
  end

  def appsubgroup_create
    @group = Group.find_by(id: params[:id])
    @appsubgroup = Appsubgroup.new(
                  user_id: @current_user.id,
                  group_id: params[:id]
                  )
    @appsubgroup.save
      flash[:notice] = "#{@group.name}に申請を送りました"
      redirect_to('/pralics/index')
  end

  def appsubgroup_destroy
    @group = Group.find_by(id: params[:id])
    @appsubgroup = Appsubgroup.find_by(group_id: params[:id],user_id: @current_user.id)
    @appsubgroup.destroy
    flash[:notice] = "#{@group.name}への申請を取り消しました"
    redirect_to('/pralics/index')
  end

  def create
    @user = User.new(
            name: params[:name],
            password: params[:password],
            user_id: params[:user_id],
            email: params[:email],
            image: "userdef.jpg",
            sex: params[:sex],
            age: params[:age],
            user_info: 0,
          )
    if @user.save
      session[:id] = @user.id
      redirect_to('/pralics/index')
    else
      render('users/signup')
    end
  end

  def account_destroy
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
    @appsubgroups = Appsubgroup.where(user_id: @user.id)
    @informations = Information.where(user_id: @user.id)
    @resources = Resource.where(user_id: @user.id)
    @attends = Attend.where(user_id: @user.id)
    @usersubgroups = Usersubgroup.where(user_id: @user.id)
    if @likes
        @likes.each do |like|
          like.destroy
        end
    end
    if @appsubgroups
        @appsubgroups.each do |appsubgroup|
          appsubgroup.destroy
        end
    end
    if @informations
        @informations.each do |information|
          information.destroy
        end
    end
    if @resources
        @resources.each do |resource|
          resource.destroy
        end
    end
    if @attends
        @attends.each do |attend|
          attend.destroy
        end
    end
    if @usersubgroups
        @usersubgroups.each do |usersubgroup|
          usersubgroup.destroy
        end
    end
    @user.destroy
    session[:id] = nil
    redirect_to('/pralics')
  end

  def login_system
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect_to('/pralics/index')
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render('users/login')
    end
  end

  def logout_system
    session[:id] = nil
    redirect_to('/pralics')
  end

end
