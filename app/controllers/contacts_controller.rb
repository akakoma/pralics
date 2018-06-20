class ContactsController < ApplicationController
  before_action :set_current_company
  before_action :set_current_manager
  before_action :forbid_login_company,{only:[:review_create]}

  def room
    @estaevent = Estaevent.find_by(room_id: params[:room_id])
    if @estaevent.room_id == nil
      redirect_to("/pralics")
    end
    @company = Company.find_by(id: @estaevent.company_id)
    @messages = Message.where(room_id: @estaevent.room_id)
    @group = Group.find_by(id: @estaevent.group_id)
    @user = User.find_by(id: @estaevent.user_id)
    if @current_company
      @estaevent.company_count = @estaevent.company_count + 1
      @estaevent.save
    else
      @estaevent.user_count = @estaevent.user_count + 1
      @estaevent.save
    end
    if @current_user && @current_user.id != @user.id || @current_company && @current_company.id != @company.id
      redirect_to("/pralics")
    end
  end

  def org_room
    @event = Event.find_by(room_id: params[:room_id])
    if @event.room_id == nil
      redirect_to("/pralics")
    end
    @organizer = User.find_by(organizer_id: @event.organizer_id)
    @messages = Message.where(room_id: @event.room_id)
    @company = Company.find_by(id: @event.company_id)
    if @current_company
      @event.company_count += 1
      @event.save
    else
      @event.user_count += 1
      @event.save
    end
    if @current_user && @current_user.id != @organizer.id || @current_company && @current_company.id != @company.id
      redirect_to("/pralics")
    end
  end

  def conf
    estaevent = Estaevent.find_by(id: params[:id])
    estaevent.conf = 'ok'
    estaevent.save
    @user = User.find_by(id: estaevent.user_id)
    @company = Company.find_by(id: estaevent.company_id)
    @message = Message.new(
      to_name: @company.name,
      from_name: @user.name,
      room_id: estaevent.room_id,
      company_count: estaevent.company_count,
      text: "#{@user.name}様からイベント内容が承認されました。<br>
      企業の方はイベントの確定をお願いいたします。"
    )
    @message.save
    redirect_to("/contacts/#{estaevent.room_id}/room")
  end

  def cancel_conf
    estaevent = Estaevent.find_by(id: params[:id])
    estaevent.conf = ""
    estaevent.save
    @user = User.find_by(id: estaevent.user_id)
    @company = Company.find_by(id: estaevent.company_id)
    @message = Message.new(
      to_name: @company.name,
      from_name: @user.name,
      room_id: estaevent.room_id,
      company_count: estaevent.company_count,
      text: "#{@user.name}様からイベント内容が承認が取り消されました。<br>
      企業の方はイベントの編集をお願いいたします。"
    )
    @message.save
    redirect_to("/contacts/#{estaevent.room_id}/room")
  end

  def org_conf
    event = Event.find_by(id: params[:id])
    event.conf = 'ok'
    event.save
    @user = User.find_by(organizer_id: event.organizer_id)
    @company = Company.find_by(id: event.company_id)
    @message = Message.new(
      to_name: @company.name,
      from_name: @user.name,
      room_id: event.room_id,
      company_count: event.company_count,
      text: "#{@user.name}様からイベント内容が承認されました。<br>
      企業の方はイベントの確定をお願いいたします。"
    )
    @message.save
    redirect_to("/contacts/#{event.room_id}/org_room")
  end

  def cancel_org_conf
    event = Event.find_by(id: params[:id])
    event.conf = ''
    event.save
    @user = User.find_by(organizer_id: event.organizer_id)
    @company = Company.find_by(id: event.company_id)
    @message = Message.new(
      to_name: @company.name,
      from_name: @user.name,
      room_id: event.room_id,
      company_count: event.company_count,
      text: "#{@user.name}様からイベント内容がキャンセルされました。<br>
      企業の方はイベントの編集をお願いいたします。"
    )
    @message.save
    redirect_to("/contacts/#{event.room_id}/org_room")
  end

  def thanks

  end

  def review
    estaevent = Estaevent.find_by(id: params[:id])
    user = User.find_by(id: estaevent.user_id)
    company = Company.find_by(id: estaevent.company_id)
    message = Message.new(
      to_name: user.name,
      from_name: company.name,
      room_id: estaevent.room_id,
      user_count: estaevent.user_count,
      text: "【#{company.name}】からレビューの申請が行われました。<br>
      【#{user.name}】様は下のボタンから、レビューの記入をお願いいたします。<br>
      <a class=\"review-btn\" href=\"/contacts/#{estaevent.id}/review_create\">レビューの記入を行う</a>"
    )
    @information = Information.new(
      user_id: user.id,
      title: "【#{company.name}】レビューの申請が行われました。",
      body: "【#{company.name}】レビューの申請が行われました。<br>
      トーク画面に行って、今回開催したイベントのレビューを作成しましょう。<br>
      <a class=\"review-btn\" href=\"/contacts/#{estaevent.id}/review_create\">レビューの記入を行う</a>"
    )
    @information.save
    message.save
    redirect_to("/contacts/#{estaevent.room_id}/room")
  end

  def review_create
    @estaevent = Estaevent.find_by(id: params[:id])
    if @estaevent.review
      redirect_to('/pralics/index')
    end
  end



  def create
    @estaevent = Estaevent.find_by(id: params[:id])
    @message = Message.new(room_id: @estaevent.room_id)
    @user = User.find_by(id: @estaevent.user_id)
    @company = Company.find_by(id: @estaevent.company_id)
    if @current_company
      @message.from_name = @company.name
      @message.to_name = @user.name
      @message.user_count = @estaevent.user_count
    else
      @message.from_name = @user.name
      @message.to_name = @company.name
      @message.company_count = @estaevent.company_count
    end
    if params[:text]
      @message.text = params[:text]
    end
    if params[:image]
      @message.image = "me_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/message_images/#{@message.image}", image.read)
    end
    if @message.save
      redirect_to("/contacts/#{@message.room_id}/room")
    else
      redirect_to("/contacts/#{@message.room_id}/romm")
  end
  end

  def org_create
    @event = Event.find_by(id: params[:id])
    @message = Message.new(room_id: @event.room_id)
    @company = Company.find_by(id: @event.company_id)
    @user = User.find_by(organizer_id: @event.organizer_id)
    if @current_company
      @message.from_name = @company.name
      @message.to_name = @user.name
      @message.user_count = @event.user_count
    else
      @message.from_name = @user.name
      @message.to_name = @company.name
      @message.company_count = @event.company_count
    end
    if params[:text]
      @message.text = params[:text]
    end
    if params[:image]
      @message.image = "org_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/message_images/#{@message.image}", image.read)
    end
    if @message.save
      redirect_to("/contacts/#{@message.room_id}/org_room")
    else
      redirect_to("/contacts/#{@message.room_id}/org_romm")
  end
  end

  def contact_form
  end

  def contact_create
    @contact = Contact.new(
      reply: 'not',
      title: params[:title],
      message: params[:message]
    )
    if @current_company
      @contact.name = @current_company.name
      @contact.email = @current_company.email
    elsif @current_user
      @contact.name = @current_user.name
      @contact.email = @current_user.email
    end
    if @contact.save
      redirect_to('/contacts/thanks')
    else
      @error_message = "お問い合わせの種類または内容は必ずご記入ください"
      @message = params[:message]
      @title = params[:title]
      render('contacts/contact_form')
    end
  end


  end
