import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

import '../../../utils/api_helper.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  Duration totalDuration = Duration(seconds: 0);
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  RxInt index = 0.obs;
  RxList<Song> l2 = <Song>[].obs;

  void changeIndex(int i) {
    index.value = i;
  }

  void getMusic() async {
    List<Song>? l1 = await APIHelper.apiHelper.getData();
    l2.value = l1!;
  }
  Future<void> initMusic() async {
    await assetsAudioPlayer.open(
      Playlist(
          audios: l2.map((e) => Audio.network(e.data.url)).toList(),
          startIndex: index.value
      ),
      autoStart: false,
      showNotification: true,
    );
    totalDuration = assetsAudioPlayer.current.value!.audio.duration;
  }

  RxBool isPlay = true.obs;
  void changeButton(bool play)
  {
    isPlay.value = play;
  }
  void previousOrNext(int r)
  {
    if(r<0)
    {
      index.value=l2.length-1;
    }
    else if(r>l2.length-1)
    {
      index.value=0;
    }
    else
    {
      index.value=r;
    }

  }
}

