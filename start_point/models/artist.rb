require_relative('../db/sql_runner')
require_relative('./album.rb')

class Artist
  attr_reader :id
  attr_accessor :name
  def initialize(options)
    @id = options['id'].to_i unless options['id'] == nil
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

  def self.find_by_id(id)
    sql = "
    SELECT * FROM artists
    WHERE id = $1
    ;"
    values = [id]
    object_array = SqlRunner.run(sql, values)
    object = Artist.new(object_array.first) unless object_array.first == nil
    return object
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

  def update()
    sql = "
    UPDATE artists
    SET name = $1
    WHERE id = $2
    ;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "
      DELETE FROM artists
      WHERE id = $1
    ;"
    values = [@id]
    SqlRunner.run(sql, values)
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
