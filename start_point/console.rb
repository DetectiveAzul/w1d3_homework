require_relative('models/artist')
require_relative('models/album')
require('pry')

Album.drop()
Artist.drop()
Artist.create()
Album.create()

artist01 = Artist.new( { 'name' => 'ACDC' })
artist02 = Artist.new( { 'name' => 'Blind Guardian'})
artist01.save()
artist02.save()
album01 = Album.new( {
  'title' => 'Highway to Hell',
  'genre' => 'Heavy Metal',
  'artist_id' => artist01.id
})
album02 = Album.new( {
  'title' => 'Nightfall in Middle-Earth',
  'genre' => 'Folk Metal',
  'artist_id' => artist02.id
})
album01.save()
album02.save()

binding.pry
nil
