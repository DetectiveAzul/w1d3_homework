require_relative('../db/sql_runner')
require_relative('./album.rb')

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

  def self.all()
    sql = "SELECT * FROM artists"
    list = SqlRunner.run(sql)
    return list.map { |hash| Artist.new(hash) }
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

  def albums()
    sql = "
    SELECT * FROM albums
    WHERE
    artist_id = $1"
    values = [@id]
    albums_list = SqlRunner.run(sql, values)
    return albums_list.map { |album_hash| Album.new(album_hash) }
  end
end
