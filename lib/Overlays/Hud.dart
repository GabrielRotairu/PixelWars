import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../Scenes/PixelWars.dart';
import 'LifesP1.dart';
import 'LifesP2.dart';

class Hud1 extends PositionComponent with HasGameRef<PixelWars> {
  Hud1({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  }) {
    positionType = PositionType.viewport;
  }

  late TextComponent _scoreTextComponent;

  @override
  Future<void>? onLoad() async {
    _scoreTextComponent = TextComponent(
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(10, 10, 10, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(180 ,55),
    );
    add(_scoreTextComponent);

    final starSprite = await game.loadSprite('star.png');
    add(
      SpriteComponent(
        sprite: starSprite,
        position: Vector2(227 ,39),
        size: Vector2.all(30),
        anchor: Anchor.topRight
      ),
    );

    for (var i = 1; i <= game.lifesP1; i++) {
      final positionX = 40 * i;
      await add(
        LifesP1(
          heartNumber: i,
          position: Vector2(positionX.toDouble(), 20),
          size: Vector2.all(32),
        ),
      );
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.lifesP1 == 0 || position.x < size.x || game.lifesP2==0) {
      removeFromParent();
    }

  }
}


class Hud2 extends PositionComponent with HasGameRef<PixelWars> {
  Hud2({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  }) {
    positionType = PositionType.viewport;
  }

  late TextComponent _scoreTextComponent;

  @override
  Future<void>? onLoad() async {
    for (var i = 1; i <= game.lifesP2; i++) {
      final positionX = 40 * i;
      await add(
        LifesP2(
          heartNumber: i,
          position: Vector2(positionX.toDouble(), 60),
          size: Vector2.all(32),
        ),
      );
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.lifesP2 == 0 || position.x < size.x ) {
      removeFromParent();
    }

  }
}
