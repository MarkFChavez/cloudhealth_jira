Rails.application.routes.draw do
  root "cloudhealth#index"

  get "/signin" => "jira_sessions#new", as: :signin
  get "/auth" => "jira_sessions#authorize"
end
