class Song {
  String song;
  SongData data;
  List<dynamic> singer = [];
  String Album;

  Song({
    required this.song,
    required this.data,
    required this.singer,
    required this.Album,
  });

  factory Song.mapToModel(Map m1) {
    return Song(
        Album: m1['Album'],
        data: SongData.mapToModel(m1['data']),
        singer: m1['singer'],
        song: m1['song']);
  }
}

class SongData {
  String image;
  String url;

  SongData({
    required this.image,
    required this.url,
  });

  factory SongData.mapToModel(Map m1) {
    return SongData(image: m1['image'], url: m1['url']);
  }
}
