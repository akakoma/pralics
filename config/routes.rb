Rails.application.routes.draw do

# companies
  get 'companies/index' => "companies#index"
  get 'companies/:id/groups_about' => "companies#groups_about"
  get 'companies/login' => "companies#login"
  get 'companies/list' => "companies#list"
  get 'companies/:id/body_edit' => "companies#body_edit"
  get 'companies/:id/event_about' => "companies#event_about"
  get 'companies/:id/event_edit' => "companies#event_edit"
  get 'companies/:id/about' => "companies#about"
  get 'companies/:id/image' => "companies#image"
  get 'companies/:id/image_edit' => "companies#image_edit"
  get 'companies/:id/example' => "companies#example"
  get 'companies/:id/example_edit' => "companies#example_edit"
  get 'companies/informations' => "companies#informations"
  get 'companies/:id/information_about' => "companies#information_about"
  post 'companies/login_system' => "companies#login_system"
  post 'companies/logout_system' => "companies#logout_system"
  post 'companies/:id/event_edit_system' => "companies#event_edit_system"
  post 'companies/:id/event_destroy_system' => "companies#event_destroy_system"
  post 'companies/:id/event_provide_system' => "companies#event_provide_system"
  post 'companies/:id/event_create' => "companies#event_create"
  post 'companies/:id/edit' => "companies#edit"
  post 'companies/:id/example_create' => "companies#example_create"
  post 'companies/:id/example_edit_system' => "companies#example_edit_system"
  post 'companies/:id/body_edit_system' => "companies#body_edit_system"
  post 'companies/likes/:event_id/create' => "companies#like_create"
  post 'companies/likes/:event_id/destroy' => "companies#like_destroy"


# groups
  get 'groups/signup' => "groups#signup"
  get 'groups/:name/create_conf' => "groups#create_conf"
  get 'groups/:id/about' => "groups#about"
  get 'groups/:id/image' => "groups#image"
  get 'groups/:id/esta_attend' => "groups#esta_attend"
  get 'groups/:id/esta_users' => "groups#esta_users"
  get 'groups/:id/manager_login' => "groups#manager_login"
  get 'groups/:id/manager' => "groups#manager"
  get 'groups/:id/information' => "groups#information"
  get 'groups/:id/name_edit' => "groups#name_edit"
  get 'groups/:id/image_edit' => "groups#image_edit"
  get 'groups/:id/genre_edit' => "groups#genre_edit"
  get 'groups/:id/password_edit' => "groups#password_edit"
  get 'groups/:id/information_about' => "groups#information_about"
  get 'groups/:id/resource' => "groups#resource"
  get 'groups/:id/resource_about' => "groups#resource_about"
  get 'groups/:id/resource_form' => "groups#resource_form"
  post 'groups/create' => "groups#create"
  post 'groups/:id/attend_system' => "groups#attend_system"
  post 'groups/:id/attend_destroy' => "groups#attend_destroy"
  post 'groups/:id/group_login_system' => "groups#group_login_system"
  post 'groups/:id/usersubgroup_destroy' => "groups#usersubgroup_destroy"
  post 'groups/:id/edit' => "groups#edit"
  post 'groups/:id/cancel_add' => "groups#cancel_add"
  post 'groups/:id/per_add' => "groups#per_add"
  post 'groups/:id/sub_destroy' => "groups#sub_destroy"
  post 'groups/:id/destroy' => "groups#destroy"
  post 'groups/:id/information_create' => "groups#information_create"
  post 'groups/:id/resource_edit' => "groups#resource_edit"
  post 'groups/:id/resource_destroy' => "groups#resource_destroy"
  post 'groups/:id/resource_create' => "groups#resource_create"



# contacts
  get 'contacts' => "contacts#contact_form"
  get 'contacts/thanks' => "contacts#thanks"
  get 'contacts/:room_id/room' => "contacts#room"
  get 'contacts/:room_id/org_room' => "contacts#org_room"
  get 'contacts/:id/review_create' => "contacts#review_create"
  post 'contacts/contact_create' => "contacts#contact_create"
  post 'contacts/:id/create' => "contacts#create"
  post 'contacts/:id/org_create' => "contacts#org_create"
  post 'contacts/:id/conf' => "contacts#conf"
  post 'contacts/:id/cancel_conf' => "contacts#cancel_conf"
  post 'contacts/:id/org_conf' => "contacts#org_conf"
  post 'contacts/:id/cancel_org_conf' => "contacts#cancel_org_conf"
  post 'contacts/:id/review' => "contacts#review"




 # events
  get 'events/:id/about' => "events#about"
  get 'events/:id/estaevent' => "events#estaevent"
  get 'events/:id/protevent' => "events#protevent"
  get 'events/:organizer_id/make_event' => "events#make_event"
  get 'events/thanks' => "events#thanks"
  get 'events/party' => "events#party"
  get 'events/trip' => "events#trip"
  get 'events/other' => "events#other"
  get 'events/fitness' => "events#fitness"
  get 'events/seminar' => "events#seminar"
  post 'events/:id/protevent_create' => "events#protevent_create"
  post 'events/:organizer_id/event_create' => "events#event_create"
  post 'events/:id/attend' => "events#attend"
  post 'events/:id/room_id_create' => "events#room_id_create"
  post 'events/:id/permission' => "events#permission"
  post 'events/:id/esta_edit' => "events#esta_edit"
  post 'events/:id/event_edit' => "events#event_edit"
  post 'events/:id/review_create_system' => "events#review_create_system"
  post 'event_likes/:event_id/create' => "events#like_create"
  post 'event_likes/:event_id/destroy' => "events#like_destroy"





# home
  get 'pralics' => "home#top"
  get 'pralics/index' => "home#index"
  post 'pralics/search' => "home#search"

# manegers
  get 'managers' => "managers#index"
  get 'managers/login' => "managers#login"
  get 'managers/users' => "managers#users"
  get 'managers/users/:id/edit' => "managers#users_edit"
  get 'managers/groups' => "managers#groups"
  get 'managers/groups/:id/edit' => "managers#groups_edit"
  get 'managers/companies' => "managers#companies"
  get 'managers/companies/:id/edit' => "managers#companies_edit"
  get 'managers/events' => "managers#events"
  get 'managers/events/:id/edit' => "managers#events_edit"
  get 'managers/estaevents' => "managers#estaevents"
  get 'managers/estaevents/:id/edit' => "managers#estaevents_edit"
  get 'managers/managers' => "managers#managers"
  get 'managers/managers/:id/edit' => "managers#managers_edit"
  get 'managers/attends' => "managers#attends"
  get 'managers/attends/:id/edit' => "managers#attends_edit"
  get 'managers/likes' => "managers#likes"
  get 'managers/likes/:id/edit' => "managers#likes_edit"
  get 'managers/usersubgroups' => "managers#usersubgroups"
  get 'managers/usersubgroups/:id/edit' => "managers#usersubgroups_edit"
  get 'managers/messages' => "managers#messages"
  get 'managers/messages/:id/edit' => "managers#messages_edit"
  get 'managers/appsubgroups' => "managers#appsubgroups"
  get 'managers/appsubgroups/:id/edit' => "managers#appsubgroups_edit"
  get 'managers/resources' => "managers#resources"
  get 'managers/resources/:id/edit' => "managers#resources_edit"
  get 'managers/new' => "managers#new"
  get 'managers/information' => "managers#information"
  get 'managers/informations' => "managers#informations"
  get 'managers/informations/:id/edit' => "managers#informations_edit"

  post 'managers/users/:id/update' => "managers#users_update"
  post 'managers/users/:id/destroy' => "managers#users_destroy"
  post 'managers/groups/:id/update' => "managers#groups_update"
  post 'managers/groups/:id/destroy' => "managers#groups_destroy"
  post 'managers/companies/:id/update' => "managers#companies_update"
  post 'managers/companies/:id/destroy' => "managers#companies_destroy"
  post 'managers/events/:id/update' => "managers#events_update"
  post 'managers/events/:id/destroy' => "managers#events_destroy"
  post 'managers/estaevents/:id/update' => "managers#estaevents_update"
  post 'managers/estaevents/:id/destroy' => "managers#estaevents_destroy"
  post 'managers/managers/:id/update' => "managers#managers_update"
  post 'managers/managers/:id/destroy' => "managers#managers_destroy"
  post 'managers/attends/:id/update' => "managers#attends_update"
  post 'managers/attends/:id/destroy' => "managers#attends_destroy"
  post 'managers/likes/:id/update' => "managers#likes_update"
  post 'managers/likes/:id/destroy' => "managers#likes_destroy"
  post 'managers/usersubgroups/:id/update' => "managers#usersubgroups_update"
  post 'managers/usersubgroups/:id/destroy' => "managers#usersubgroups_destroy"
  post 'managers/messages/:id/update' => "managers#messages_update"
  post 'managers/messages/:id/destroy' => "managers#messages_destroy"
  post 'managers/appsubgroups/:id/update' => "managers#appsubgroups_update"
  post 'managers/appsubgroups/:id/destroy' => "managers#appsubgroups_destroy"
  post 'managers/resources/:id/update' => "managers#resources_update"
  post 'managers/resources/:id/destroy' => "managers#resources_destroy"
  post 'managers/information_create' => "managers#information_create"
  post 'managers/informations/:id/update' => "managers#informations_update"
  post 'managers/informations/:id/destroy' => "managers#informations_destroy"
  post 'managers/users/create' => "managers#users_create"
  post 'managers/groups/create' => "managers#groups_create"
  post 'managers/companies/create' => "managers#companies_create"
  post 'managers/events/create' => "managers#events_create"
  post 'managers/estaevents/create' => "managers#estaevents_create"
  post 'managers/managers/create' => "managers#managers_create"
  post 'managers/attends/create' => "managers#attends_create"
  post 'managers/likes/create' => "managers#likes_create"
  post 'managers/usersubgroups/create' => "managers#usersubgroups_create"
  post 'managers/messages/create' => "managers#messages_create"
  post 'managers/appsubgroups/create' => "managers#appsubgroups_create"
  post 'managers/resources/create' => "managers#resources_create"
  post 'managers/login' => "managers#login_system"
  post 'managers/logout' => "managers#logout_system"
  get 'managers/contacts' => "managers#contacts"
  get 'managers/contacts/:id/about' => "managers#contact_about"
  post 'managers/contacts/:id/reply' => "managers#contact_reply"
  post 'managers/contacts/:id/destroy' => "managers#contact_destroy"



# users
  get 'users/login' => "users#login"
  get 'users/signup' => "users#signup"
  get 'users/join' => "users#join"
  get 'users/:id/info' => "users#info"
  get 'users/:name/join' => "users#join"
  get 'users/:id/email_edit' => "users#email_edit"
  get 'users/:id/user_id_edit' => "users#user_id_edit"
  get 'users/:id/password_edit' => "users#password_edit"
  get 'users/:id/image_edit' => "users#image_edit"
  get 'users/:id/image' => "users#image"
  get 'users/informations' => "users#informations"
  get 'users/:id/organizer' => "users#organizer"
  get 'users/organizer/thanks' => "users#thanks"
  get 'users/:id/information_about' => "users#information_about"
  post 'users/:id/edit' => "users#edit"
  post 'users/:id/account_destroy' => "users#account_destroy"
  post 'users/create' => "users#create"
  post 'login' => "users#login_system"
  post 'logout' => "users#logout_system"
  post 'users/appsubgroup/:id/create' => "users#appsubgroup_create"
  post 'users/appsubgroup/:id/destroy' => "users#appsubgroup_destroy"
  post 'users/likes/:event_id/create' => "users#like_create"
  post 'users/likes/:event_id/destroy' => "users#like_destroy"
  post 'users/:id/organizer_contact' => "users#organizer_contact"


# like
  post 'likes/:event_id/create' => "likes#create"
  post 'likes/:event_id/destroy' => "likes#destroy"
  post 'likes/:event_id/party_create' => "likes#party_create"
  post 'likes/:event_id/party_destroy' => "likes#party_destroy"
  post 'likes/:event_id/trip_create' => "likes#trip_create"
  post 'likes/:event_id/trip_destroy' => "likes#trip_destroy"
  post 'likes/:event_id/fitness_create' => "likes#fitness_create"
  post 'likes/:event_id/fitness_destroy' => "likes#fitness_destroy"
  post 'likes/:event_id/other_create' => "likes#other_create"
  post 'likes/:event_id/other_destroy' => "likes#other_destroy"
  post 'likes/:event_id/seminar_create' => "likes#seminar_create"
  post 'likes/:event_id/seminar_destroy' => "likes#seminar_destroy"

end
