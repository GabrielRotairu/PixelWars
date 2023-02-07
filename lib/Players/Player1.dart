import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forge2d/src/dynamics/body.dart';
import 'package:juego1/Scenes/PixelWars.dart';

class Fighter extends SpriteAnimationComponent with HasGameRef<PixelWars> {
  Fighter({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.center);
  bool hitByEnemy = false;
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

class FighterBody extends BodyComponent<PixelWars> with KeyboardHandler,ContactCallbacks {
  Vector2 position;
  Vector2 size = Vector2(64, 64);
  int verticalDirection = 0;
  int horizontalDirection = 0;
  double jumpSpeed = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  late Fighter emberPlayer;
  bool hitByEnemy = false;

  FighterBody({required this.position});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    emberPlayer = Fighter(position: Vector2.zero());
    emberPlayer.size = size;
    add(emberPlayer);
    renderBody = true;
  }

  @override
  Body createBody() {
    // TODO: implement createBody
    BodyDef definicionCuerpo= BodyDef(position: position,type: BodyType.dynamic,
      userData: this,);
    Body cuerpo = world.createBody(definicionCuerpo);

    final shape = CircleShape();
    shape.radius = size.x / 2;

    FixtureDef fixtureDef = FixtureDef(shape, restitution: 0.5);
    cuerpo.createFixture(fixtureDef);

    return cuerpo;
  }

/*
  @override
  void onMount() {
    super.onMount();
    camera.followBodyComponent(this);
  }*/

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {


    horizontalDirection = 0;
    verticalDirection = 0;

    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      horizontalDirection = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      horizontalDirection = 1;
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      verticalDirection = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      verticalDirection = 1;
    }
/*
    if (keysPressed.contains(LogicalKeyboardKey.keyS) &&
        (event is RawKeyDownEvent) &&
        jumpSpeed == 0) {
      jumpSpeed = 2000;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyS) &&
        (event is RawKeyUpEvent) &&
        jumpSpeed == 2000) {
      jumpSpeed = 0;
    }*/
    game.setDirection(horizontalDirection, verticalDirection);

    return true;
  }

  @override
  void update(double dt) {
    // TODO: implement update

    velocity.x = horizontalDirection * moveSpeed;
    velocity.y = verticalDirection * moveSpeed;
    velocity.y += -1 * jumpSpeed;

    center.add((velocity * dt));
    if (horizontalDirection < 0 && emberPlayer.scale.x > 0) {
      //flipAxisDirection(AxisDirection.left);
      //flipAxis(Axis.horizontal);
      emberPlayer.flipHorizontallyAroundCenter();
    } else if (horizontalDirection > 0 && emberPlayer.scale.x < 0) {
      //flipAxisDirection(AxisDirection.left);
      emberPlayer.flipHorizontallyAroundCenter();
    }
    super.update(dt);
  }
}
