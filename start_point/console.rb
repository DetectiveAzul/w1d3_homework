require_relative('models/artist')
require_relative('models/album')
require('pry')

Album.drop()
Artist.drop()
Artist.create()
Album.create()

artist01 = Artist.new( { 'name' => 'ACDC' })
artist02 = Artist.new( { 'name' => 'Blind Guardian'})
artist03 = Artist.new( { 'name' => 'Mojinos Escocíos' })
artist01.save()
artist02.save()
artist03.save()

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
album03 = Album.new( {
  'title' => 'High Voltage',
  'genre' => 'Heavy Metal',
  'artist_id' => artist01.id
})
album04 = Album.new( {
  'title' => 'At The Edge Of Time',
  'genre' => 'Folk Metal',
  'artist_id' => artist02.id
})
album01.save()
album02.save()
album03.save()
album04.save()


album01.title = 'En Un Cortijo Grande'
album01.artist_id = artist03.id
album01.update()

artist03.name = 'Tributo a Mojinos'
artist03.update()

album01.delete()
artist03.delete()

binding.pry()
nil
