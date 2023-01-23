import 'package:flame/components.dart';
import 'package:juego1/Scenes/PixelWars.dart';

class StarElement extends SpriteComponent with HasGameRef<PixelWars> {
  StarElement({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();

    SpriteComponent component = SpriteComponent.fromImage(
        game.images.fromCache("star.png"),
        anchor: Anchor.bottomCenter);

    add(component);
  }
}
