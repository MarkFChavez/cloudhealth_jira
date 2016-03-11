class CloudhealthController < ApplicationController
  before_action :get_jira_client
  
  def index
    render text: "no sprint specified" and return unless params[:sprint]
    
    @issues = @jira_client.Issue.jql("PROJECT = REL", max_results: 1_000_000)

    @issues = @issues.select do |issue|
      sprint = issue.customfield_10007
      sprint.first =~ /name=#{params[:sprint]},/ rescue false
    end
  
    @issues = @issues.group_by do |issue|
      issue.assignee.try(:name)
    end.select { |k, v| k.present? }

    @issues = @issues.map do |username, issues|
      story_points = issues.sum do |issue|
        issue.customfield_10004 || 0
      end

      { name: username, total: story_points }
    end.sort_by { |hash| hash[:total] }.reverse
  end
end
