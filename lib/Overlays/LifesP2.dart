
import 'package:flame/components.dart';
import 'package:juego1/Scenes/PixelWars.dart';

enum HeartState {
  available,
  unavailable,
}

class LifesP2 extends SpriteGroupComponent<HeartState>
    with HasGameRef<PixelWars> {
  final int heartNumber;

  LifesP2({
    required this.heartNumber,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final availableSprite = await game.loadSprite(
      'heartP2.png',
      srcSize: Vector2.all(32),
    );



    sprites = {
      HeartState.available: availableSprite,
    };

    current = HeartState.available;
  }

  @override
  void update(double dt) {
    if (game.lifesP2 < heartNumber) {
      current = HeartState.unavailable;
    } else {
      current = HeartState.available;
    }
    if (game.lifesP1 == 0 || position.x < size.x) {
      removeFromParent();
      super.update(dt);

    }


  }

}