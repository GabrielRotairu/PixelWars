import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:juego1/Players/Player1.dart';
import 'package:juego1/Scenes/PixelWars.dart';

class StarElement extends BodyComponent <PixelWars> with ContactCallbacks {

  bool isTaken = false;

  late Vector2 position;
  Vector2 sizeEstrellas = Vector2(64, 64);
  late StarElement estrellasElement;


  StarElement({required this.position});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    estrellasElement = StarElement(position: Vector2.zero());
    renderBody = true;
    estrellasElement = StarElement(position: Vector2.zero());
    estrellasElement.sizeEstrellas = sizeEstrellas;
    add(estrellasElement);
    renderBody = true;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    if (isTaken) {
      world.destroyBody(body);
      gameRef.remove(this);
      print("hola");
    }
    final platFormImage = game.images.fromCache("star.png");
     Sprite sprite = Sprite(platFormImage);
    add(RectangleHitbox()
      ..collisionType = CollisionType.passive);
  }


  void hit() {
    isTaken = true;
  }

  @override
   Body createBody() {
    BodyDef definicionCuerpo = BodyDef(
      position: position, type: BodyType.static,
      userData: this,);
    Body cuerpo = world.createBody(definicionCuerpo);

    final shape = CircleShape();
    shape.radius = sizeEstrellas.x / 2;

    FixtureDef fixtureDef = FixtureDef(
    shape
        //density: 10.0,
        //friction: 0.2,
    );
    cuerpo.createFixture(fixtureDef);
    return cuerpo;
  }

        @override
        void beginContact(Object other, Contact contact) {
      if (other is FighterBody) {
        hit();
        print("Eliminada...");
      }
    }



  }





