require_relative('../db/sql_runner')
require_relative('./artist')

class Album
  attr_reader :id
  attr_accessor :title, :genre, :artist_id
  def initialize(options)
    @id = options['id'] unless options['id'] == nil
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']
  end

  def self.drop()
    sql = "DROP TABLE IF EXISTS albums;"
    SqlRunner.run(sql)
  end

  def self.create()
    sql = "
    CREATE TABLE albums (
      id SERIAL8 PRIMARY KEY,
      title VARCHAR(255),
      genre VARCHAR(255),
      artist_id INT8 REFERENCES artists(id)
    );"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    list = SqlRunner.run(sql)
    return list.map { |hash| Album.new(hash) }
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def save()
    sql = "
    INSERT INTO albums
    (title, genre, artist_id)
    VALUES
    ($1, $2, $3)
    RETURNING id;"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def update()
    sql = "
    UPDATE albums
    SET (title, genre, artist_id)
    = ($1, $2, $3)
    WHERE id = $4
    ;"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "
      DELETE FROM albums
      WHERE id = $1
    ;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql = "
    SELECT * FROM artists
    WHERE
    id = $1"
    values = [@artist_id]
    artist_array = SqlRunner.run(sql, values)
    return Artist.new(artist_array.first)
  end
end
