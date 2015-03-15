class MockEntity
  class << self
    def collection
      @collection ||= {}
    end

    def all
      collection.values
    end

    def truncate!
      @collection = {}
    end

    def first_by_identifier(identifier)
      collection[identifier.to_i]
    end

    def count
      all.count
    end
  end

  def initialize(identifier)
    @identifier = identifier
    self.class.collection[identifier] = self
  end

  def id
    @identifier
  end

  def update(hsh)
    hsh.each do |key, value|
      self.send(:"#{key}=", value)
    end
  end
end