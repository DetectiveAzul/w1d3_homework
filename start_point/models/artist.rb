class Artist
  attr_reader :id, :name
  def initialize(options)
    @id = options['id'] unless options['id'] == nil
    @name = options['name']
  end

  def self.drop()
    sql = "DROP TABLE IF EXISTS artists;"
    SqlRunner.run(sql)
  end

  def self.create()
    sql = "
    CREATE TABLE artists(
      id SERIAL8 PRIMARY KEY,
      name VARCHAR(255)
    );"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
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
