class Activity
    attr_accessor :id
    attr_accessor :repository_id
    attr_accessor :description
    attr_accessor :type

  
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  
    def persisted?
      false
    end
end