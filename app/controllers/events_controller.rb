class EventsController < ApplicationController
  before_action :set_current_company
  before_action :authenticate_user,{only:[:about,:protevent,:make_event,:esta_edit,:event_edit,
    :attend,:permission,:review_create_system,:event_create,:protevent_create,:room_id_create,
    ]}
  before_action :forbid_login_company,{only:[:about]}

  def party
    @events_par = Event.where(genre:'パーティー').order('likes_count desc')
  end

  def trip
    @events_trip = Event.where(genre:'旅行').order('likes_count desc')
  end

  def fitness
    @events_fit = Event.where(genre:'フィットネス').order('likes_count desc')
  end

  def seminar
    @events_sem = Event.where(genre:'セミナー').order('likes_count desc')
  end

  def other
    @events_other = Event.where(genre:'その他').order('likes_count desc')
  end

  def about
    @event = Event.find_by(id: params[:id])
    @estaevents = Estaevent.where(event_id: params[:id])
    @company = Company.find_by(id: @event.company_id)
    @organizer = User.find_by(organizer_id: @event.organizer_id)
    @usersubgroups = Usersubgroup.where(user_id: @current_user.id)
  end

  def estaevent
    @estaevent = Estaevent.find_by(id: params[:id])
    @group = Group.find_by(id: @estaevent.group_id)
    @company = Company.find_by(id: @estaevent.company_id)
  end

  def protevent
    @estaevent = Estaevent.find_by(id: params[:id])
    @company = Company.find_by(id: @estaevent.company_id)
    @group = Group.find_by(id: @estaevent.group_id)
  end

  def make_event
    @event = Event.new
    @organizer = User.find_by(organizer_id: params[:organizer_id])
    @companies = Company.all
  end

  def esta_edit
    @estaevent = Estaevent.find_by(id: params[:id])
    @user = User.find_by(id: @estaevent.user_id)
    @company = Company.find_by(id: @estaevent.company_id)
    @estaevent.title = params[:title]
    @estaevent.genre = params[:genre]
    @estaevent.people = params[:people]
    @estaevent.price = params[:price]
    @estaevent.place = params[:place]
    @estaevent.time = params[:time]
    @estaevent.day = params[:day]
    @estaevent.body = params[:body]
    @message = Message.new(
      to_name: @user.name,
      from_name: @company.name,
      room_id: @estaevent.room_id,
      user_count: @estaevent.user_count,
      text: "イベント内容の編集が行われました。<br>
      編集内容をご確認ください。<br>
      すべての条件が確定しましたら、
      <br>#{@user.name}様は確認画面から「承認する」を押してください。"
    )
    @message.save
    @estaevent.save
    redirect_to("/contacts/#{@estaevent.room_id}/room")
  end

  def event_edit
    @event = Event.find_by(id: params[:id])
    @user = User.find_by(organizer_id: @event.organizer_id)
    @company = Company.find_by(id: @event.company_id)
    @event.title = params[:title]
    @event.genre = params[:genre]
    @event.bottom_people = params[:bottom_people]
    @event.top_people = params[:top_people]
    @event.bottom_price = params[:bottom_price]
    @event.top_price = params[:top_price]
    @event.place = params[:place]
    @event.time = params[:time]
    @event.day = params[:day]
    @event.body = params[:body]
    @message = Message.new(
      to_name: @user.name,
      from_name: @company.name,
      room_id: @event.room_id,
      user_count: @event.user_count,
      text: "イベント内容の編集が行われました。<br>
      編集内容をご確認ください。<br>
      すべての条件が確定しましたら、
      <br>#{@user.name}様は確認画面から「承認する」を押してください。"
    )
    @message.save
    @event.save
    redirect_to("/contacts/#{@event.room_id}/org_room")
  end

  def attend
    @estaevent = Estaevent.find_by(id: params[:id])
    group = Group.find_by(id: @estaevent.group_id)
    usersubgroups = Usersubgroup.where(group_id: group.id)
    usersubgroups.each do |subg|
      @attend = Attend.new(
        user_id: subg.user_id,
        estaevent_id: @estaevent.id
      )
      @attend.save
    end
    @user = User.find_by(id: @estaevent.user_id)
    @company = Company.find_by(id: @estaevent.company_id)
    @message = Message.new(
      to_name: @user.name,
      from_name: @company.name,
      room_id: @estaevent.room_id,
      user_count: @estaevent.user_count,
      text: "イベント情報が確定し、<br>
      【#{group.name}】にイベント情報の掲載が行われ、<br>
      【#{@estaevent.title}】の出席受付が開始されました。"
    )
    @information = Information.new(
      group_id: group.id,
      title: "【#{@estaevent.title}】新しいイベントが企画されました。",
      body: "【#{@estaevent.title}】新しいイベントが企画されました。<br>
      団体ページに行って内容を確認してみましょう。<br>
      <a class=\"review-btn\" href=\"/groups/#{@estaevent.id}/esta_attend\">詳細に移る</a>"
    )
    @information.save
    @message.save
    redirect_to("/contacts/#{@estaevent.room_id}/room")
  end

  def permission
    @event = Event.find_by(id: params[:id])
    @event.permission = 'ok'
    @user = User.find_by(organizer_id: @event.organizer_id)
    @company = Company.find_by(id: @event.company_id)
    @message = Message.new(
      to_name: @user.name,
      from_name: @company.name,
      room_id: @event.room_id,
      user_count: @event.user_count,
      text: "イベント情報が確定し、<br>
      #{@user.name}様のユーザー情報にイベント情報の掲載が行われ、<br>
      【#{@event.title}】の開催受付が可能になりました。<br>
      所属団体にて、イベントの開催を行ってください。
      <a class=\"review-btn\" href=\"/events/#{@event.id}/about\">イベントの開催を行う</a>
      "
    )
    @message.save
    @event.save
    redirect_to("/contacts/#{@event.room_id}/org_room")
  end

  def review_create_system
    @estaevent = Estaevent.find_by(id: params[:id])
    if params[:review] == nil || params[:review] == ''
      @error_message = "レビューを記入してください"
      render('contacts/review_create')
      return
    else
      @estaevent.review = params[:review]
    end
    @estaevent.room_id = ""
    if params[:image]
      @estaevent.image = "est_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}.jpg"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/company_event_images/#{@estaevent.image}", image.read)
    end
    @estaevent.people = Attend.where(estaevent_id: @estaevent.id).length
    @attends = Attend.where(estaevent_id: @estaevent.id)
    @messages = Message.where(room_id: @estaevent.room_id)
    @attends.each do |attend|
      attend.destroy
    end
    @messages.each do |message|
      message.destroy
    end
    @estaevent.save
    redirect_to("/events/thanks")
   end

  def event_create
    @company = Company.find_by(id: params[:company_id])
    @event = Event.new(
      title: params[:title],
      image: @company.image,
      place: params[:place],
      top_price: params[:top_price],
      bottom_price: params[:bottom_price],
      body: params[:body],
      top_people: params[:top_people],
      bottom_people: params[:bottom_people],
      time: params[:time],
      day: params[:day],
      genre: params[:genre],
      company_id: @company.id,
      organizer_id: params[:organizer_id],
      provide: 'close',
      room_id: "or_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}",
      user_count: 0,
      company_count: 0,
      likes_count: 0
    )
    if params[:image]
      @event.image = "ev_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}"
      image = params[:image]
      File.binwrite("#{Rails.root}/public/company_event_images/#{@event.image}", image.read)
    end
    if @event.save
      redirect_to("/contacts/#{@event.room_id}/org_room")
    else
      @companies = Company.all
      render("events/make_event")
    end
  end

  def protevent_create
    @event = Event.find_by(id: params[:id])
    @company = Company.find_by(id: @event.company_id)
    if  params[:title] != nil  || params[:place] != nil || params[:price] != nil|| params[:people] != nil|| params[:time] != nil|| params[:day] != nil|| params[:genre] != nil|| params[:body] != nil|| params[:group_id] != nil
      @estaevent = Estaevent.new(
        title: params[:title],
        image: @event.image,
        place: params[:place],
        price: params[:price],
        people: params[:people],
        time: params[:time],
        day: params[:day],
        genre: params[:genre],
        user_id: @current_user.id,
        company_id: @company.id,
        body: params[:body],
        event_id: @event.id,
        group_id: params[:group_id],
        user_count: 0,
        company_count: 0
      )
      @estaevent.save
    else
      e = Estaevent.find_by(id: params[:id])

      @estaevent = Estaevent.new(
        title: e.title,
        image: e.image,
        place: e.place,
        price: e.price,
        people: e.people,
        time: e.time,
        day: e.day,
        genre: e.genre,
        user_id: @current_user.id,
        company_id: e.company_id,
        body: e.body,
        event_id: e.event_id,
        group_id: e.group_id,
        user_count: 0,
        company_count: 0
      )
        @estaevent.save
    end
        redirect_to("/events/#{@estaevent.id}/protevent")
  end

  def room_id_create
    estaevent = Estaevent.find_by(id: params[:id])
    @event = Event.find_by(id: estaevent.event_id)
    @company = Company.find_by(id: @event.company_id)
    estaevent.room_id = "ro_#{rand(999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)}"
    estaevent.save
    if @event.organizer_id
      u = User.find_by(organizer_id: @event.organizer_id)
      @information = Information.new(
        user_id: u.id,
        title: "【#{@event.title}】主催しているイベントで企画が行われました。",
        body: "【#{@event.title}】<br>主催しているイベントで企画が行われました。<br>
        提携企業と連絡を取ってください。<br>
        <a class=\"review-btn\" href=\"/contacts/#{@event.room_id}/org_room\">提携企業とのコンタクト画面に移る</a>"
      )
      @information.save
      @message = Message.new(
        to_name: u.name,
        from_name: @company.name,
        room_id: @event.room_id,
        user_count: @event.user_count,
        text: "
        【#{@event.title}】<br>主催しているイベントで企画が行われました。
        "
      )
      @message.save
    end
    redirect_to("/contacts/#{estaevent.room_id}/room")
  end

  def like_create
    @event = Event.find_by(id: params[:event_id])
    @like = Like.new(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @like.save
    @event.likes_count += 1
    @event.save
    redirect_to("/events/#{@event.id}/about")
  end

  def like_destroy
    @event = Event.find_by(id: params[:event_id])
    @like = Like.find_by(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @like.destroy
    @event.likes_count += 1
    @event.save
    redirect_to("/events/#{@event.id}/about")
  end

end
