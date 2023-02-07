import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:forge2d/src/dynamics/body.dart';
import 'package:juego1/Players/Player1.dart';
import 'package:juego1/Scenes/PixelWars.dart';

class Gota extends SpriteAnimationComponent with HasGameRef<PixelWars> {
  Gota({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(16, 16),
        stepTime: 0.12,
      ),
    );
  }
}

class GotaBody extends BodyComponent<PixelWars> with KeyboardHandler,ContactCallbacks {
  Vector2 position;
  Vector2 size = Vector2(64, 64);
  int verticalDirection = 0;
  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  late Gota waterPlayer;
  bool isContact=false;
  final shape=CircleShape();


  GotaBody({required this.position});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    waterPlayer = Gota(position: Vector2.zero());
    waterPlayer.size = size;
    add(waterPlayer);
    renderBody = true;
  }

  @override
  Body createBody() {
    // TODO: implement createBody
    BodyDef bodyDef = BodyDef(type: BodyType.dynamic, position: position,);
    Body cuerpo = world.createBody(bodyDef);

    final shape = CircleShape();
    shape.radius = size.x / 2;

    FixtureDef fixtureDef = FixtureDef(shape, restitution: 0.5);
    cuerpo.createFixture(fixtureDef);

    return cuerpo;
  }
  void move() async{
    isContact=true;
    if(isContact){
      waterPlayer.size=size/2;
      await Future.delayed(Duration(seconds: 3));
      isContact=false;
      // print("han pasado 5 segundos"+ isContact.toString());
      waterPlayer.size=size;
    }
  }




  @override
  void beginContact(Object other, Contact contact) {
    if (other is FighterBody) {
      hit();
      print("hoooola");
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    horizontalDirection = 0;
    verticalDirection = 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalDirection = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalDirection = 1;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      verticalDirection = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      verticalDirection = 1;
    }

    game.setDirection(horizontalDirection, verticalDirection);

    return true;
  }
  void hit() {
    isContact = true;
  }
  @override
  void update(double dt) {
    // TODO: implement update

    velocity.x = horizontalDirection * moveSpeed;
    velocity.y = verticalDirection * moveSpeed;

    center.add((velocity * dt));
    if (horizontalDirection < 0 && waterPlayer.scale.x > 0) {
      //flipAxisDirection(AxisDirection.left);
      //flipAxis(Axis.horizontal);
      waterPlayer.flipHorizontallyAroundCenter();
    } else if (horizontalDirection > 0 && waterPlayer.scale.x < 0) {
      //flipAxisDirection(AxisDirection.left);
      waterPlayer.flipHorizontallyAroundCenter();
    }
    if (isContact) {
      world.destroyBody(body);
      gameRef.remove(this);
      print("hoola");

  }

    super.update(dt);
  }
}
