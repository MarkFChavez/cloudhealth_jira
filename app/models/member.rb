class Member
  attr_reader :display_name, :issues

  def initialize(display_name, issues)
    @display_name = display_name
    @issues = issues
  end

  def issues_done
    issues.select do |issue|
      issue.fields["status"]["statusCategory"]["name"] == "Done" rescue false
    end
  end

  def points_done
    issues_done.sum do |issue|
      issue.customfield_10004 || 0
    end
  end

  def avatar(size = "24x24")
    return unless issues.first

    issue = issues.first

    issue.assignee.avatarUrls[size]
  end
end
