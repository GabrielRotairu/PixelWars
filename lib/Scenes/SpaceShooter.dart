import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:juego1/Players/Player1.dart';

class SpaceShooter extends FlameGame with HasTappables {


  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {}
}
