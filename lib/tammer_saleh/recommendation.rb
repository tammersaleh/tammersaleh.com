class Recommendation
  def self.random
    new(recommendations_data.sample)
  end

  def initialize(values = {})
    @values = HashWithIndifferentAccess.new(values)
  end

  def method_missing(*args, &block)
    if key = args.first and @values.has_key?(key)
      @values[key]
    else
      raise NoMethodError.new("#{key} not in #{@values.inspect}")
    end
  end

  def inspect
    "Recommendation: #{@values.inspect}"
  end

  def to_s; inspect; end

  private

  def self.recommendations_data
    JSON.parse(File.read(json_file))
  end

  def self.json_file
    File.join(TammerSaleh.settings.config, "recommendations.json")
  end

end
