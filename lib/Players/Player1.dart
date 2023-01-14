import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forge2d/src/dynamics/body.dart';
import 'package:juego1/Scenes/KombatGame.dart';
import 'package:juego1/Scenes/PixelWars.dart';

class Fighter extends SpriteAnimationComponent with HasGameRef<PixelWars> {

  Fighter({required super.position}) : super(size: Vector2.all(64), anchor : Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(16, 16),
        stepTime: 0.12,
      ),
    );


  }




}
