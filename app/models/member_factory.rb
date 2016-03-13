class MemberFactory
  def self.build(members)
    new(members).build
  end

  attr_reader :members

  def initialize(members)
    @members = members
  end

  def build
    members.map do |display_name, issues|
      Member.new(display_name, issues)
    end
  end
end
