class Album
  attr_reader :id, :title, :genre, :artist_id
  def initialize(options)
    @id = options['id'] unless options['id'] == nil
    @title = options['title']
    @genre = options['genre']
    @artist_id = optiones['artist_id']
  end
end
