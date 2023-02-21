import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

final pathToSaveAudio = 'audio.aac';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isrecorderinitialized = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print(status);
      throw RecordingPermissionException('microphone access not granted');
    }
    await _audioRecorder!.openRecorder();
    _isrecorderinitialized = true;
  }

  void dispose() {
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _isrecorderinitialized = false;
  }

  Future _record() async {
    if (!_isrecorderinitialized) return;
    await _audioRecorder!.startRecorder(
      toFile: pathToSaveAudio,
    );
  }

  Future _stop() async {
    if (!_isrecorderinitialized) return;
    final path = await _audioRecorder!.stopRecorder();
    print("record: " + path!);
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
