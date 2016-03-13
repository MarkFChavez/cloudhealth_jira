class Member
  attr_reader :display_name, :issues

  def initialize(display_name, issues)
    @display_name = display_name
    @issues = issues
  end

  def story_points
    issues.sum do |issue|
      issue.customfield_10004 || 0
    end
  end

  def avatar(size = "24x24")
    return unless issues.first

    issue = issues.first

    issue.assignee.avatarUrls[size]
  end
end
