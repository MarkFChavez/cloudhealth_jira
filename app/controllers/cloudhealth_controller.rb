class CloudhealthController < ApplicationController
  before_action :get_jira_client
  
  def index
    @issues = @jira_client.Issue.jql("PROJECT = REL")

    # only get issues that came from 2.28
    @issues = @issues.select do |issue|
      sprint = issue.customfield_10007

      if sprint and sprint.any?
        regex = /name=2.28/
        sprint.first =~ regex
      end
    end
  end
end
