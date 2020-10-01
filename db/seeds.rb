Song.destroy_all
User.destroy_all
user1 = User.create(name: "Eric Christine", age: 22, mood: "happy")
user2 = User.create(name: "Marcos Lipic", age: 24, mood: "happy")

Song.destroy_all
song1 = Song.create(title: "What's My Age Again?", artist: "Blink-182", lyrics: "carefree")
song2 = Song.create(title: "Electric Feel", artist: "MGMT", lyrics: "love")
song3 = Song.create(title: "Be Above It", artist: "Tame Impala", lyrics: "motivated")
song4 = Song.create(title: "Going Native", artist: "Summer Salt", lyrics: "happy")
song5 = Song.create(title: "Yer Blues", artist: "The Beatles", lyrics: "sad")

# Keyword.create(user: user1, song: song4, mood: "happy")
