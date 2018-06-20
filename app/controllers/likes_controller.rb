class LikesController < ApplicationController
  before_action :authenticate_user
  def create
    @event = Event.find_by(id: params[:event_id])
    @like = Like.new(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count += 1
    @event.save
    @like.save
    redirect_to("/pralics/index")
  end

  def destroy
    @event = Event.find_by(id: params[:event_id])
    @like = Like.find_by(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count -= 1
    @event.save
    @like.destroy
    redirect_to("/pralics/index")
  end

  def party_create
    @event = Event.find_by(id: params[:event_id])
    @like = Like.new(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count += 1
    @event.save
    @like.save
    redirect_to("/events/party")
  end

  def party_destroy
    @event = Event.find_by(id: params[:event_id])
    @like = Like.find_by(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count -= 1
    @event.save
    @like.destroy
    redirect_to("/events/party")
  end
  def trip_create
    @event = Event.find_by(id: params[:event_id])
    @like = Like.new(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count += 1
    @event.save
    @like.save
    redirect_to("/events/trip")
  end

  def trip_destroy
    @event = Event.find_by(id: params[:event_id])
    @like = Like.find_by(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count -= 1
    @event.save
    @like.destroy
    redirect_to("/events/trip")
  end
  def fitness_create
    @event = Event.find_by(id: params[:event_id])
    @like = Like.new(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count += 1
    @event.save
    @like.save
    redirect_to("/events/fitness")
  end

  def fitness_destroy
    @event = Event.find_by(id: params[:event_id])
    @like = Like.find_by(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count -= 1
    @event.save
    @like.destroy
    redirect_to("/events/fitness")
  end
  def other_create
    @event = Event.find_by(id: params[:event_id])
    @like = Like.new(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count += 1
    @event.save
    @like.save
    redirect_to("/events/other")
  end

  def other_destroy
    @event = Event.find_by(id: params[:event_id])
    @like = Like.find_by(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count -= 1
    @event.save
    @like.destroy
    redirect_to("/events/other")
  end
  def seminar_create
    @event = Event.find_by(id: params[:event_id])
    @like = Like.new(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count += 1
    @event.save
    @like.save
    redirect_to("/events/seminar")
  end

  def seminar_destroy
    @event = Event.find_by(id: params[:event_id])
    @like = Like.find_by(
      user_id: @current_user.id,
      event_id: params[:event_id]
    )
    @event.likes_count -= 1
    @event.save
    @like.destroy
    redirect_to("/events/seminar")
  end
end
