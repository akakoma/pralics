class CompaniesController < ApplicationController
  before_action :set_current_company
  before_action :authenticate_user,{only:[:list]}
  before_action :authenticate_company,{only:[:index,:informations,:information_about,:body_edit_system,
    :event_about,:event_create,:event_edit,:body_edit,:image_edit,:example,:example_edit,:example_edit_system,
    :example_create,:edit,:event_edit_system,:event_provide_system,:event_destroy_system,:groups_about,
    ]}
  before_action :forbid_login_company,{only:[:login]}


  def login

  end

  def index
    @events = Event.where(company_id: @current_company.id)
    @estaevents = Estaevent.where(company_id: @current_company.id)
    a = Information.where(company_id: @current_company.id)
    b = Information.where(company_id: 0)
    @informations = a + b
  end

  def groups_about
    @group = Group.find_by(id: params[:id])
    @usersubgroups = Usersubgroup.where(group_id: @group.id)
    @estaevents = Estaevent.where(group_id: @group.id)
    @appsubgroups = Appsubgroup.where(group_id: @group.id)
  end

  def list
      @companies = Company.all
  end

  def informations
    @informations = Information.all.order("id DESC")
    a = Information.where(company_id: @current_company.id)
    b = Information.where(company_id: 0)
    @current_company.company_info = a.length + b.length
    @current_company.save
  end

  def information_about
    @information = Information.find_by(id: params[:id])
    if @information.company_id != 0
      @company = Company.find_by(id: @information.company_id)
      if @company == nil
          redirect_to('/pralics')
      end
    end
  end

  def body_edit_system
    @company = Company.find_by(id: params[:id])
    @company.body = params[:body]
    @company.save
    redirect_to("/companies/#{@company.id}/about")
  end

  def event_about
    @event = Event.find_by(id: params[:id])
    @organizer = User.find_by(organizer_id: @event.organizer_id)
    @company = Company.find_by(id: @event.company_id)
  end

  def event_create
    company = Company.find_by(id: params[:id])
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
      provide: "open",
      company_id: company.id,
      organizer_id: nil,
      body: params[:body],
      image: company.image,
      user_count: 1,
      company_count: 1,
      likes_count: 0
    )
    if params[:image]
      @event.image = "co_ev_#{rand(99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/company_event_images/#{@event.image}", image.read)
    end
    @event.save!
    redirect_to("/companies/index")
  end

  def event_edit
    @event = Event.find_by(id: params[:id])
  end

  def about
    @company = Company.find_by(id: params[:id])
    @events = Event.where(company_id: params[:id])
  end

  def body_edit
    @company = Company.find_by(id: params[:id])
  end

  def image
    @company = Company.find_by(id: params[:id])
  end

  def image_edit
    @company = Company.find_by(id: params[:id])
  end

  def example
    @event = Event.find_by(id: params[:id])
    @example = Estaevent.new
    @company = Company.find_by(id: @event.company_id)
  end

  def example_edit
    @example = Estaevent.new
    @estaevent = Estaevent.find_by(id: params[:id])
    @company = Company.find_by(id:@estaevent.company_id)
  end

  def example_edit_system
    @example = Estaevent.find_by(id: params[:id])
    @example.genre = params[:genre]
    @example.price = params[:price]
    @example.place = params[:place]
    @example.time = params[:time]
    @example.day = params[:day]
    @example.body = params[:body]
    if @example.save
      redirect_to("/events/#{@example.id}/estaevent")
    else
      render('companies/example_edit')
    end
  end

  def example_create
    @event = Event.find_by(id: params[:id])
    @example = Estaevent.new(
      title: "利用例",
      review: "※これは利用例です。",
      image: @event.image,
      place: params[:place],
      price: params[:price],
      body: params[:body],
      time: params[:time],
      day: params[:day],
      genre: params[:genre],
      event_id: @event.id,
      people: 0,
      company_id: @current_company.id,
      user_count: 1,
      company_count: 1
    )
    if @example.save
    redirect_to("/companies/index")
    else
      render("companies/example")
    end
  end

  def edit
    @company = Company.find_by(id: params[:id])
    @company.image = "co_ev_#{rand(99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
    image = params[:image]
    File.binwrite("#{Rails.root}/public/company_event_images/#{@company.image}", image.read)
    @company.save
    redirect_to("/companies/#{@company.id}/about")
  end



  def event_edit_system
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
    @event.body = params[:body]
    if params[:image]
      @event.image = "co_ev_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/company_event_images/#{@event.image}", image.read)
    end
    @event.save
      redirect_to("/companies/#{@event.id}/event_about")
  end

  def event_provide_system
    @event = Event.find_by(id: params[:id])
    if @event.provide == "open"
      @event.provide = "close"
    else
       @event.provide = "open"
    end
    @event.save
    redirect_to('/companies/index')
  end

  def event_destroy_system
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
    @attends.each do |attend|
      attend.destroy
    end
    @es_messages.each do |es_message|
      es_message.destroy
    end
    @event.destroy
    redirect_to('/companies/index')
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
    @company = Company.find_by(id: @event.company_id)
    redirect_to("/companies/#{@company.id}/about")
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
    @company = Company.find_by(id: @event.company_id)
    redirect_to("/companies/#{@company.id}/about")
  end

  def login_system
    @company = Company.find_by(name: params[:name])
    if @company && @company.authenticate(params[:password])
      session[:company_id] = @company.id
      redirect_to('/companies/index')
    else
      @error_message = "企業名またはパスワードが間違っています"
      @name = params[:name]
      @password = params[:password]
      render('companies/login')
    end
  end

  def logout_system
    session[:company_id] = nil
    redirect_to('/companies/login')
  end


end
