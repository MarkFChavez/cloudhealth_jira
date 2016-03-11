class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from JIRA::OauthClient::UninitializedAccessTokenError do
    render text: "token error" and return
  end

  rescue from Net::OpenTimeout do
    render text: "timeout" and return
  end


  private

  def get_jira_client
    options = {
      private_key_file: "rsakey.pem",
      consumer_key: Rails.application.secrets.consumer_key,
      site: Rails.application.secrets.site,
      context_path: ""
    }

    @jira_client = JIRA::Client.new(options)

    if session[:jira_auth]
      @jira_client.set_access_token(
        session[:jira_auth]["access_token"],
        session[:jira_auth]["access_key"]
      )
    end
  end
end
