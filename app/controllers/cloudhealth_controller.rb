class CloudhealthController < ApplicationController
  before_action :get_jira_client
  
  def index
    render "no_sprint_found" and return unless (params[:sprint] and params[:sprint].present?)

    @members = MemberFactory.build(members)
    @members = @members.sort_by do |member|
      member.points_done
    end.reverse
  end

  private

  def members
    issues = @jira_client.Issue.jql("PROJECT = REL", max_results: 10_000_000)

    issues = issues.select do |issue|
      sprint = issue.customfield_10007
      sprint.first =~ /name=#{params[:sprint]},/ rescue false
    end
  
    issues = issues.group_by do |issue|
      issue.assignee.try(:displayName)
    end.select { |k, v| k.present? }

    issues
  end
end
