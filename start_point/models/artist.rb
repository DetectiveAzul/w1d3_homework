class Artist
  attr_reader :id, :name
  def initialize(options)
    @id = options['id'] unless options['id'] == nil
    @name = options['name']
  end

  def save()
    sql = "
    INSERT INTO artists
    (name)
    VALUES
    ($1)
    RETURNING id;"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end
end
