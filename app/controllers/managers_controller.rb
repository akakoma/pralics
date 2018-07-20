class ManagersController < ApplicationController
  before_action :set_current_manager
  before_action :authenticate_manager,{only:[:index,:users,:users_edit,:groups,:groups_edit,:companies,:companies_edit,
    :events,:events_edit,:estaevents,:estaevents_edit,:managers,:managers_edit,:attends,:attends_edit,:likes,:likes_edit,
    :usersubgroups,:usersubgroups_edit,:messages,:messages_edit,:appsubgroups,:appsubgroups_edit,:informations,:informations_edit,
    :resources, :resources_edit, :users_destroy,:users_update,:groups_update,:groups_destroy,:companies_update,:companies_destroy,
    :events_update,:events_destroy,:estaevents_update,:estaevents_destroy,:managers_update,:managers_destroy,:attends_update,
    :attends_destroy,:likes_update,:likes_destroy,:usersubgroups_update,:usersubgroups_destroy,:messages_update,:messages_destroy,
    :appsubgroups_update,:appsubgroups_destroy,:informations_update,:informations_destroy,:resources_update,:resources_destroy,
    :new,:users_create,:groups_create,:companies_create,:events_create,:estaevents_create,:managers_create,:likes_create,:attends_create,
    :usersubgroups_create,:messages_create,:appsubgroups_create,:resources_create,:information,:information_create,:contacts,
    :contact_about,:contact_reply,:contact_destroy
]}
  before_action :forbid_login_manager,{only:[:login]}

  def index
  end

  def login
  end

  def users
    @users = User.all
  end

  def users_edit
    @user = User.find_by(id: params[:id])
  end

  def groups
    @groups = Group.all
  end

  def groups_edit
    @group = Group.find_by(id: params[:id])
  end

  def companies
    @companies = Company.all
  end

  def companies_edit
    @company = Company.find_by(id: params[:id])
  end

  def events
    @events = Event.all
  end

  def events_edit
    @event = Event.find_by(id: params[:id])
  end

  def estaevents
    @estaevents = Estaevent.all
  end

  def estaevents_edit
    @estaevent = Estaevent.find_by(id: params[:id])
  end

  def managers
    @managers = Manager.all
  end

  def managers_edit
    @manager = Manager.find_by(id: params[:id])
  end

  def attends
    @attends = Attend.all
  end

  def attends_edit
    @attend = Attend.find_by(id: params[:id])
  end

  def likes
    @likes = Like.all
  end

  def likes_edit
    @like = Like.find_by(id: params[:id])
  end

  def usersubgroups
    @usersubgroups = Usersubgroup.all
  end

  def usersubgroups_edit
    @usersubgroup = Usersubgroup.find_by(id: params[:id])
  end

  def messages
    @messages = Message.all
  end

  def messages_edit
    @message = Message.find_by(id: params[:id])
  end

  def appsubgroups
    @appsubgroups = Appsubgroup.all
  end


  def appsubgroups_edit
    @appsubgroup = Appsubgroup.find_by(id: params[:id])
  end

  def informations
    @informations = Information.all
  end

  def informations_edit
    @information = Information.find_by(id: params[:id])
  end

  def resources
    @resources = Resource.all
  end

  def resources_edit
    @resource = Resource.find_by(id: params[:id])
  end

  def users_update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.user_id = params[:user_id]
    @user.email = params[:email]
    @user.image = params[:image]
    @user.organizer_id = params[:organizer_id]
    @user.save
    redirect_to('/managers/users')
  end

  def users_destroy
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
    redirect_to('/managers/users')
  end

  def groups_update
    @group = Group.find_by(id: params[:id])
    @group.name = params[:name]
    @group.genre = params[:genre]
    @group.group_type = params[:group_type]
    @group.format = params[:format]
    @group.sub_password = params[:sub_password]
    @group.mana_password = params[:mana_password]
    @group.save
    redirect_to('/managers/groups')
  end

  def groups_destroy
    @group = Group.find_by(id: params[:id])
    @usersubgroups = Usersubgroup.where(group_id: @group.id)
    @appsubgroups = Appsubgroup.where(group_id: @group.id)
    @informations = Information.where(group_id: @group.id)
    @estaevents = Estaevent.where(group_id: @group.id)
    if @estaevents
      @estaevents.each do |estaevent|
        @attends = Attend.where(estaevent_id: estaevent.id)
        @messages = Message.where(room_id: estaevent.room_id)
        estaevent.destroy
      end
      if @attends
        @attends.each do |attend|
          attend.destroy
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
    @group.destroy
    redirect_to('/managers/groups')
  end

  def companies_update
    @company = Company.find_by(id: params[:id])
    @company.name = params[:name]
    @company.image = params[:image]
    @company.genre = params[:genre]
    @company.email = params[:email]
    @company.password = params[:password]
    @company.manager = params[:manager]
    @company.tel = params[:tel]
    @company.company_info = params[:company_info]
    @company.body = params[:body]
    @company.save
    redirect_to('/managers/companies')
  end

  def companies_destroy
    @company = Company.find_by(id: params[:id])
    @events = Event.where(company_id: @company.id)
    @f_messages = Message.where(from_name: @company.name)
    @t_messages = Message.where(to_name: @company.name)
    @events.each do |event|
      @estaevents = Estaevent.where(event_id: event.id)
      @likes = Like.where(event_id: event.id)
      @informations = Information.where(company_id: @company.id)
      event.destroy
    end
    if @f_messages
      @f_messages.each do |f_message|
        f_message.destroy
      end
    end
    if @t_messages
      @t_messages.each do |t_message|
        t_message.destroy
      end
    end
    if @estaevents
      @estaevents.each do |estaevent|
        estaevent.destroy
      end
    end
    if @likes
      @likes.each do |like|
        like.destroy
      end
    end
    if @messages
      @messages.each do |message|
        message.destroy
      end
    end
    if @informations
      @informations.each do |information|
        information.destroy
      end
    end
    @company.destroy
    redirect_to('/managers/companies')
  end

  def events_update
    @event = Event.find_by(id: params[:id])
    @event.title = params[:title]
    @event.place = params[:place]
    @event.top_price = params[:top_price]
    @event.bottom_price = params[:bottom_price]
    @event.top_people = params[:top_people]
    @event.bottom_people = params[:bottom_people]
    @event.time = params[:time]
    @event.day = params[:day]
    @event.genre = params[:genre]
    @event.conf = params[:conf]
    @event.organizer_id = params[:organizer_id]
    @event.company_id = params[:company_id]
    @event.provide = params[:provide]
    @event.user_count = params[:user_count]
    @event.company_count = params[:company_count]
    @event.permission = params[:permission]
    @event.body = params[:body]
    if params[:image]
    @event.image = "#{@event.id}.jpg"
  end
    @event.save
    redirect_to('/managers/events')
  end

  def events_destroy
    @event = Event.find_by(id: params[:id])
    @messages = Message.where(room_id: @event.room_id)
    @likes = Like.where(event_id: @event.id)
    @estaevents = Estaevent.where(event_id: @event.id)
    @estaevents.each do |estaevent|
      @attends = Attend.where(estaevent_id: estaevent.id)
      @es_messages = Message.where(room_id: estaevent.room_id)
      estaevent.destroy
    end
    @messages.each do |message|
      message.destroy
    end
    @likes.each do |like|
      like.destroy
    end
    if @attends
    @attends.each do |attend|
      attend.destroy
    end
    end
    if @es_messages
    @es_messages.each do |es_message|
      es_message.destroy
    end
    end
    @event.destroy
    redirect_to('/managers/events')
  end

  def estaevents_update
    @estaevent = Estaevent.find_by(id: params[:id])
    @estaevent.title = params[:title]
    @estaevent.image = params[:image]
    @estaevent.place = params[:place]
    @estaevent.title = params[:title]
    @estaevent.body = params[:body]
    @estaevent.review = params[:review]
    @estaevent.time = params[:time]
    @estaevent.people = params[:people]
    @estaevent.day = params[:day]
    @estaevent.genre = params[:genre]
    @estaevent.conf = params[:conf]
    @estaevent.room_id = params[:room_id]
    @estaevent.user_id = params[:user_id]
    @estaevent.company_id = params[:company_id]
    @estaevent.event_id = params[:event_id]
    @estaevent.group_id = params[:group_id]
    @estaevent.company_count = params[:company_count]
    @estaevent.user_count = params[:user_count]
    @estaevent.save
    redirect_to('/managers/estaevents')
  end

  def estaevents_destroy
    @estaevent = Estaevent.find_by(id: params[:id])
    @attends = Attend.where(estaevent_id: params[:id])
    @attends.each do |attend|
      attend.destroy
    end
    @information = Information.new(
      user_id: @estaevent.user_id,
      company_id: @estaevent.company_id,
      title: "【#{@estaevent.title}】イベントが中止されました。",
      body: "【#{@estaevent.title}】イベントが中止されました。<br>
      またのご利用をお待ちしております。"
    )
    if @estaevent.group_id
      @information.group_id =  @estaevent.group_id
    end
    @information.save
    @estaevent.destroy
    redirect_to('/managers/estaevents')
  end

  def managers_update
    @manager = Manager.find_by(id: params[:id])
    @manager.name = params[:name]
    @manager.password = params[:password]
    @manager.save
    redirect_to('/managers/managers')
  end

  def managers_destroy
    @manager = Manager.find_by(id: params[:id])
    @manager.destroy
    redirect_to('/managers/managers')
  end

  def attends_update
    @attend = Attend.find_by(id: params[:id])
    @attend.estaevent_id = params[:estaevent_id]
    @attend.user_id = params[:user_id]
    @attend.save
    redirect_to('/managers/attends')
  end

  def attends_destroy
    @attend = Attend.find_by(id: params[:id])
    @attend.destroy
    redirect_to('/managers/attends')
  end

  def likes_update
    @like = Like.find_by(id: params[:id])
    @like.event_id = params[:event_id]
    @like.user_id = params[:user_id]
    @like.save
    redirect_to('/managers/likes')
  end

  def likes_destroy
    @like = Like.find_by(id: params[:id])
    @like.destroy
    redirect_to('/managers/likes')
  end

  def usersubgroups_update
    @usersubgroup = Usersubgroup.find_by(id: params[:id])
    @usersubgroup.group_id = params[:group_id]
    @usersubgroup.user_id = params[:user_id]
    @usersubgroup.group_info = params[:group_info]
    @usersubgroup.save
    redirect_to('/managers/usersubgroups')
  end

  def usersubgroups_destroy
    @usersubgroup = Usersubgroup.find_by(id: params[:id])
    @usersubgroup.destroy
    redirect_to('/managers/usersubgroups')
  end

  def messages_update
    @message = Message.find_by(id: params[:id])
    @message.to_name = params[:to_name]
    @message.from_name = params[:from_name]
    @message.text = params[:text]
    @message.room_id = params[:room_id]
    @message.user_count = params[:user_count]
    @message.company_count = params[:company_count]
    @message.save
    redirect_to('/managers/messages')
  end

  def messages_destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    redirect_to('/managers/messages')
  end

  def appsubgroups_update
    @appsubgroup = Appsubgroup.find_by(id: params[:id])
    @appsubgroup.group_id = params[:group_id]
    @appsubgroup.user_id = params[:user_id]
    @appsubgroup.save
    redirect_to('/managers/appsubgroups')
  end

  def appsubgroups_destroy
    @appsubgroup = Appsubgroup.find_by(id: params[:id])
    @appsubgroup.destroy
    redirect_to('/managers/appsubgroups')
  end

  def informations_update
    @information = Information.find_by(id: params[:id])
    @information.group_id = params[:group_id]
    @information.user_id = params[:user_id]
    @information.company_id = params[:company_id]
    @information.title = params[:title]
    @information.image = params[:image]
    @information.body = params[:body]
    if params[:image]
      @information.image = "info_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/information_images/#{@information.image}", image.read)
    end
    @information.save
    redirect_to('/managers/informations')
  end

  def informations_destroy
    @information = Information.find_by(id: params[:id])
    @information.destroy
    redirect_to('/managers/informations')
  end

  def resources_update
    @resource = Resource.find_by(id: params[:id])
    @resource.group_id = params[:group_id]
    @resource.user_id = params[:user_id]
    @resource.title = params[:title]
    @resource.body = params[:body]
    @resource.save
    redirect_to('/managers/resources')
  end

  def resources_destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    redirect_to('/managers/resources')
  end

  def new
    @user = User.new
    @group = Group.new
    @company = Company.new
    @event = Event.new
    @estaevent = Estaevent.new
    @manager = Manager.new
    @attend = Attend.new
    @like = Like.new
    @usersubgroup = Usersubgroup.new
    @message = Message.new
    @appsubgroup = Appsubgroup.new
    @resource = Resource.new
  end





  def users_create
    @user = User.new(
      name: params[:name],
      password: params[:password],
      user_id: params[:user_id],
      email: params[:email],
      organizer_id: params[:organizer_id],
      image: "userdef.jpg",
      sex: params[:sex],
      user_info: 0,
      age: params[:age]
    )
    if @user.save
      redirect_to('/managers/users')
    end
  end

  def groups_create
    @group = Group.new(
      name: params[:name],
      genre: params[:genre],
      group_type: params[:group_type],
      format: params[:format],
      sub_password: params[:sub_password],
      mana_password: params[:mana_password],
      image: "groupdef.jpg"
    )
    if @group.save
      redirect_to('/managers/groups')
    end
  end

  def companies_create
    @company = Company.new(
      name: params[:name],
      genre: params[:genre],
      email: params[:email],
      password: params[:password],
      manager: params[:manager],
      tel: params[:tel],
      image: params[:image],
      body: "#{params[:name]}です。<br>#{params[:genre]}の依頼お待ちしております。",
      company_info: 0
    )
    if @company.save!
      redirect_to('/managers/companies')
    end
  end

  def events_create
    @event = Event.new(
      title: params[:title],
      place: params[:place],
      top_price: params[:top_price],
      bottom_price: params[:bottom_price],
      top_people: params[:top_people],
      bottom_people: params[:bottom_people],
      time: params[:time],
      day: params[:day],
      genre: params[:genre],
      conf: params[:conf],
      provide: params[:provide],
      room_id: params[:room_id],
      organizer_id: params[:organizer_id],
      company_id: params[:company_id],
      body: params[:body],
      image: "event1.jpg",
      user_count: 0,
      company_count: 0,
      likes_count: 0
    )
    if @event.save
      redirect_to('/managers/events')
    end
  end

  def estaevents_create
    @estaevent = Estaevent.new(
      title: params[:title],
      place: params[:place],
      price: params[:price],
      body: params[:body],
      time: params[:time],
      day: params[:day],
      review: params[:review],
      time: params[:time],
      people: params[:people],
      genre: params[:genre],
      conf: params[:conf],
      room_id: params[:room_id],
      user_id: params[:user_id],
      company_id: params[:company_id],
      group_id: params[:group_id],
      event_id: params[:event_id],
      image: "user1.jpg",
      user_cpunt: 0,
      company_count: 0
    )
    if @estaevent.save
      redirect_to('/managers/estaevents')
    end
  end

  def managers_create
    @manager = Manager.new(
      name: params[:name],
      password: params[:password],
    )
    if @manager.save
      redirect_to('/managers/managers')
    end
  end

  def attends_create
    @attend = Attend.new(
      user_id: params[:user_id],
      estaevent_id: params[:estaevent_id],
    )
    if @attend.save
      redirect_to('/managers/attends')
    end
  end

  def likes_create
    @like = Like.new(
      user_id: params[:user_id],
      event_id: params[:event_id],
    )
    if @like.save
      redirect_to('/managers/likes')
    end
  end

  def usersubgroups_create
    @usersubgroup = Usersubgroup.new(
      user_id: params[:user_id],
      group_id: params[:group_id]
    )
    if @usersubgroup.save!
      redirect_to('/managers/usersubgroups')
    end
  end


  def messages_create
    @message = Message.new(
      to_name: params[:to_name],
      from_name: params[:from_name],
      room_id: params[:room_id],
      text: params[:text],
    )
    if @message.save
      redirect_to('/managers/messages')
    end
  end


  def appsubgroups_create
    @appsubgroup = Appsubgroup.new(
      user_id: params[:user_id],
      group_id: params[:group_id]
    )
    if @appsubgroup.save
      redirect_to('/managers/appsubgroups')
    end
  end

  def resources_create
    @resource = Resource.new(
      user_id: params[:user_id],
      group_id: params[:group_id],
      title: params[:title],
      body: params[:body]
    )
    if @resource.save
      redirect_to('/managers/resources')
    end
  end

  def information

  end

  def information_create
    @information = Information.new(
      user_id: params[:user_id],
      group_id: params[:group_id],
      company_id: params[:company_id],
      image: params[:image],
      title: params[:title],
      body: params[:body],
    )
    if params[:image]
      @information.image = "info_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/information_images/#{@information.image}", image.read)
    end
    @information.save
    redirect_to("/managers/informations")
  end

  def contacts
    @contacts = Contact.all
  end

  def contact_about
    @contact = Contact.find_by(id: params[:id])
  end

  def contact_reply
    @contact = Contact.find_by(id: params[:id])
    if @contact.reply == 'not'
      @contact.reply = "ok"
    else
      @contact.reply = 'not'
    end
    @contact.save
    redirect_to('/managers/contacts')
  end

  def contact_destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    redirect_to('/managers/contacts')
  end




  def login_system
    @manager = Manager.find_by(name: params[:name])
    if @manager && @manager.authenticate(params[:password])
      session[:manager_id] = @manager.id
      redirect_to('/managers')
    else
      @name = params[:name]
      @password = params[:password]
      render('managers/login')
    end
  end

  def logout_system
    session[:manager_id] = nil
    redirect_to('/managers/login')
  end




end
