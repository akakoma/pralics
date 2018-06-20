class GroupsController < ApplicationController
  before_action :authenticate_user
  before_action :set_current_group
  before_action :authenticate_group,{only:[:manager]}

  def signup
    @group = Group.new
  end

  def about
    @group = Group.find_by(id: params[:id])
    @usersubgroups = Usersubgroup.where(group_id: @group.id)
    @appsubgroups = Appsubgroup.where(group_id: @group.id)
    @estaevents = Estaevent.where(group_id: @group.id)
    a = Information.where(group_id: @group.id)
    b = Information.where(group_id: 0)
    @informations = a + b
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def image
    @group = Group.find_by(id: params[:id])
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def esta_attend
    @estaevent = Estaevent.find_by(id: params[:id])
    if @estaevent == nil
      redirect_to('/pralics/index')
    end
    @attends = Attend.where(estaevent_id: @estaevent.id)
    @group = Group.find_by(id: @estaevent.group_id)
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def esta_users
    @estaevent = Estaevent.find_by(id: params[:id])
    @attends = Attend.where(estaevent_id: @estaevent.id)
    @group = Group.find_by(id: @estaevent.group_id)
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def manager_login
    @group = Group.find_by(id: params[:id])
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def manager
    @group = Group.find_by(id: params[:id])
    @usersubgroups = Usersubgroup.where(group_id: @group.id)
    @appsubgroups = Appsubgroup.where(group_id: @group.id)
    @estaevents = Estaevent.where(group_id: @group.id)
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def information
    @informations = Information.all.order("id DESC")
    @group = Group.find_by(id: params[:id])
    if usersubgroup = Usersubgroup.find_by(user_id: @current_user.id,group_id: @group.id)
      a = Information.where(group_id: @group.id)
      b = Information.where(group_id: 0)
      usersubgroup.group_info = a.length + b.length
      usersubgroup.save
    else
      redirect_to('/pralics')
    end
  end

  def information_about
    @information = Information.find_by(id: params[:id])
    if @group = Group.find_by(id: @information.group_id)
      if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
        redirect_to('/pralics')
      end
    else
      redirect_to('/pralics')
    end
  end

  def resource
    @group = Group.find_by(id: params[:id])
    @resources = Resource.all.order('id DESC')
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def resource_form
    @group = Group.find_by(id: params[:id])
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def resource_create
    resource = Resource.new(
      title: params[:title],
      body: params[:body],
      user_id: @current_user.id,
      group_id: params[:id],
    )
    if resource.save
      redirect_to("/groups/#{params[:id]}/resource")
    else
      @error_message = '※タイトルまたは内容の記入をお願いいたします。'
      @group = Group.find_by(id: params[:id])
      @title = params[:title]
      @body = params[:body]
      render("groups/resource_form")
    end
  end

  def resource_about
    @resource = Resource.find_by(id: params[:id])
    @user = User.find_by(id: @resource.user_id)
    if @resource.group_id == 0
    else
      group = Group.find_by(id: @resource.group_id)
      if Usersubgroup.find_by(group_id: group.id,user_id: @current_user.id) == nil
        redirect_to('/pralics')
      end
    end
  end

  def resource_edit
    @resource = Resource.find_by(id: params[:id])
    @resource.title = params[:title]
    @resource.body = params[:body]
    @resource.save
    redirect_to("/groups/#{@resource.group_id}/resource")
  end

  def resource_destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    redirect_to("/groups/#{@resource.group_id}/resource")
  end

  def usersubgroup_destroy
    @group = Group.find_by(id: params[:id])
    @usersubgroup = Usersubgroup.find_by(user_id: @current_user.id, group_id: params[:id])
    @estaevents = Estaevent.where(group_id: @group.id)
    if @estaevents
      @estaevent.each do |estaevent|
        attend = Attend.find_by(estaevent_id: estaevent.id,user_id: @current_user.id)
        if attend
          attend.destroy
        end
      end
    end
    @usersubgroup.destroy
    redirect_to('/pralics/index')
  end

  def attend_system
    @estaevent = Estaevent.find_by(id: params[:id])
    @attend = Attend.new(
      estaevent_id: params[:id],
      user_id: @current_user.id
    )
    @attend.save
    flash[:notice] = " "
    @attends = Attend.where(estaevent_id: @estaevent.id)
      @group = Group.find_by(id: @estaevent.group_id)
    render("groups/esta_attend")
  end

  def attend_destroy
    @estaevent = Estaevent.find_by(id: params[:id])
    @attend = Attend.find_by(estaevent_id: params[:id],user_id: @current_user.id)
    @attend.destroy
    @attends = Attend.where(estaevent_id: @estaevent.id)
      @group = Group.find_by(id: @estaevent.group_id)
    render("groups/esta_attend")
  end

  def name_edit
    @group = Group.find_by(id: params[:id])
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def password_edit
    @group = Group.find_by(id: params[:id])
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def genre_edit
    @group = Group.find_by(id: params[:id])
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end

  def image_edit
    @group = Group.find_by(id: params[:id])
    if Usersubgroup.find_by(group_id: @group.id,user_id: @current_user.id) == nil
      redirect_to('/pralics')
    end
  end


  def edit
    @group = Group.find_by(id: params[:id])
    if params[:name]
      @group.name = params[:name]
    end
    if params[:genre]
      @group.genre = params[:genre]
    end
    if params[:image]
      @group.image = "gr_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/group_images/#{@group.image}", image.read)
    end
    if @group.sub_password == params[:sub_password] && params[:new_password]
      @group.sub_password = params[:new_password]
    end
      @group.save
      redirect_to("/groups/#{@group.id}/manager")
  end

  def cancel_add
    @appsubgroup = Appsubgroup.find_by(id: params[:id])
    @group = Group.find_by(id: @appsubgroup.group_id)
    @appsubgroup.destroy
    redirect_to("/groups/#{@group.id}/manager")
  end

  def per_add
    @appsubgroup = Appsubgroup.find_by(id: params[:id])
    @group = Group.find_by(id: @appsubgroup.group_id)
    @usersubgroup = Usersubgroup.new(
      user_id: @appsubgroup.user_id,
      group_id: @appsubgroup.group_id,
      group_info: 0
    )
    @usersubgroup.save
    @appsubgroup.destroy
    redirect_to("/groups/#{@group.id}/manager")
  end

  def sub_destroy
    @usersubgroup = Usersubgroup.find_by(id: params[:id])
    @group = Group.find_by(id: @usersubgroup.group_id)
    @estaevents = Estaevent.where(group_id: @group.id)
    if @estaevents
      @estaevents.each do |estaevent|
        @attends = Attend.where(user_id: @usersubgroup.user_id,estaevent_id: estaevent.id)
      end
      if @attends
        @attends.each do |attend|
          attend.destroy
        end
      end
    end
    @usersubgroup.destroy
    redirect_to("/groups/#{@group.id}/manager")
  end

  def group_login_system
    @group = Group.find_by(
            id: params[:id],
            mana_password: params[:mana_password]
          )
    if @group
      session[:group_id] = @group.id
      redirect_to("/groups/#{@group.id}/manager")
    else
      flash[:notice] = "パスワードが間違っています"
      @group = Group.find_by(id: params[:id])
      render('groups/manager_login')
    end
  end

  def create
    @group = Group.new(
      name: params[:name],
      genre: params[:genre],
      group_type: params[:group_type],
      sub_password: params[:sub_password],
      image: 'groupdef.jpg',
      mana_password: params[:mana_password],
    )
    if params[:image]
      @group.image = "gr_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/group_images/#{@group.image}", image.read)
    end
    if @group.save
      redirect_to("/groups/#{params[:name]}/create_conf")
    else
      render('/groups/signup')
    end
  end

  def information_create
    @information = Information.new(
      group_id: params[:id],
      title: params[:title],
      body: params[:body]
    )
    if params[:image]
      @information.image = "info_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/information_images/#{@information.image}", image.read)
    end
    if @information.save
      redirect_to("/groups/#{params[:id]}/manager")
    else
      @group = Group.find_by(id: params[:id])
      @usersubgroups = Usersubgroup.where(group_id: @group.id)
      @appsubgroups = Appsubgroup.where(group_id: @group.id)
      @estaevents = Estaevent.where(group_id: @group.id)
      flash[:notice] = 'タイトルまたは内容を記入して下さい'
      render('groups/manager')
    end
  end

  def create_conf
    @group = Group.find_by(name: params[:name])
    if Usersubgroup.find_by(group_id: @group.id)
      redirect_to('/pralics')
    end
    @usersubgroup = Usersubgroup.new(
      user_id: @current_user.id,
      group_id: @group.id,
      group_info: 0)
    @usersubgroup.save
  end

  def destroy
      @group = Group.find_by(id: params[:id])
      @usersubgroups = Usersubgroup.where(group_id: @group.id)
      @appsubgroups = Appsubgroup.where(group_id: @group.id)
      @informations = Information.where(group_id: @group.id)
      @estaevents = Estaevent.where(group_id: @group.id)
      @resources = Resource.where(group_id: @group.id)
      if @estaevents
        @estaevents.each do |estaevent|
          @attends = Attend.where(estaevent_id: estaevent.id)
          @messages = Message.where(room_id: estaevent.room_id)
          estaevent.destroy
        end
        if @attends
          @attends.each do |attend|
            attend.desroy
          end
          @messages.each do |message|
            message.destroy
          end
        end
      end
      @informations.each do |information|
        information.destroy
      end
      @usersubgroups.each do |usersubgroup|
        usersubgroup.destroy
      end
      @appsubgroups.each do |appsubgroup|
        appsubgroup.destroy
      end
      @resources.each do |resource|
        resource.destroy
      end
      @group.destroy
      redirect_to("/pralics/index")
  end

end
