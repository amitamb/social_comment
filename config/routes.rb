SocialComment::Application.routes.draw do
  root :to => 'social#new'

  get "social/new"

  post "social/create"

  post "social/scrape"
end
