# Making a Matcher Available
module ValidateNumericalityOf
  class Matcher
    def initialize(attribute)
    end

    def matches?(model)
      false
    end

    def failure_message
      "Not implemented"
    end

    def negative_failure_message
      "Not implemented"
    end

    def description
      "Not implemented"
    end
  end

  def validate_numericality_of(attribute)
    pending
  end
end

RSpec.configure do |config|
  config.include ValidateNumericalityOf, type: :model
end

# Initializing the matcher
module ValidateNumericalityOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
    end

    def matches?(model)
      false
    end

    def failure_message
      "Not implemented"
    end

    def negative_failure_message
      "Not implemented"
    end

    def description
      "Not implemented"
    end
  end

  def validate_numericality_of(attribute)
    Matcher.new(attribute)
  end
end

# Completing Our Basic Matcher
module ValidateNumericalityOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
    end

    def matches?(model)
      check_for_number model
    end

    def failure_message
      "Not implemented"
    end

    def negative_failure_message
      "Not implemented"
    end

    def description
      "Not implemented"
    end
    
    def check_for_number model
      model[@attribute] = "not a number"
      model.valid?
      model.errors[@attribute].include?("is not a number")
    end
  end

  def validate_numericality_of(attribute)
    Matcher.new(attribute)
  end
end

RSpec.configure do |config|
  config.include ValidateNumericalityOf, type: :model
end

# Better Descriptions
module ValidateNumericalityOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
    end

    def matches?(model)
      check_for_number model
    end

    def failure_message
      "Not implemented"
    end

    def negative_failure_message
      "Not implemented"
    end

    def description
      "validate numericality of #{@attribute} attribute"
    end
    
    def check_for_number model
      model[@attribute] = "not a number"
      model.valid?
      model.errors[@attribute].include?("is not a number")
    end
  end

  def validate_numericality_of(attribute)
    Matcher.new(attribute)
  end
end

RSpec.configure do |config|
  config.include ValidateNumericalityOf, type: :model
end

# Failure Messages
module ValidateNumericalityOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
    end

    def matches?(model)
      @model = model
      check_for_number
    end

    def failure_message
      "Zombie failed to validate: #{@model.class} #{@attribute} iq numericality"
    end

    def negative_failure_message
      "Zombie successfully validated  #{@model.class} #{@attribute} iq numericality"
    end

    def description
      "validate numericality of "
    end
    
    def check_for_number
      @model[@attribute] = "not a number"
      @model.valid?
      @model.errors[@attribute].include?("is not a number")
    end
  end

  def validate_numericality_of(attribute)
    Matcher.new(attribute)
  end
end

RSpec.configure do |config|
  config.include ValidateNumericalityOf, type: :model
end


# Chained Custom Matc
module ValidateNumericalityOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
      @options = {}
      @errors = []
    end

    def only_integers
      @options[:only_integers] = true
      self
    end
    
    def matches?(model)
      @model = model
      @model[@attribute] = "not a number"
      @model.valid?

      if !@model.errors[@attribute].include?("is not a number")
        @errors << "numericality" 
      end

      if @options[:only_integers]
        @model[@attribute] = 1.5
        @model.valid?
        if !@model.errors[@attribute].include?("must be an integer")
          @errors << "as an integer"
        end
      end

      @errors.empty?
    end

    def failure_message
      "#{@model.class} failed to validate: #{@attribute} #{@errors.join(', ')}"
    end

    def negative_failure_message
      "#{@model.class} unexpected validation: #{@attribute} #{@errors.join(', ')}"
    end

    def description
      "validate numericality of #{@attribute}"
    end
  end

  def validate_numericality_of(attribute)
    Matcher.new(attribute)
  end
end

RSpec.configure do |config|
  config.include ValidateNumericalityOf, type: :model
end
