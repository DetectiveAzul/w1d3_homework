class Artist
  attr_reader :id, :name
  def initialize(options)
    @id = options['id'] unless options['id'] == nil
    @name = options['name']
  end
end
