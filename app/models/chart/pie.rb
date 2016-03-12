module Chart
  class Pie
    attr_reader :members, :controller

    def initialize(hash, controller)
      @members = hash
      @controller = controller
    end

    def build
      members.map do |hash|
        color = random_color
        {
          value: hash[:total],
          color: "##{color}",
          label: hash[:name]
        }
      end
    end

    def options
      {
        generateLegend: true,
        legendTemplate: "<span> hello </span>"
      }
    end

    private

    def random_color
      "%06x" % (rand * 0xffffff)
    end
  end
end
