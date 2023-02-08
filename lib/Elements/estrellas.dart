import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';
import 'package:juego1/Players/Player1.dart';

import '../Players/GotaPlayer.dart';
import '../Scenes/PixelWars.dart';

class EstrellasBody extends BodyComponent <PixelWars> with ContactCallbacks {

  bool isTaken = false;

  late Vector2 position;
  Vector2 sizeEstrellas = Vector2(64, 64);
  late EstrellasElement estrellasElement;


  EstrellasBody({required this.position});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    estrellasElement = EstrellasElement(position: Vector2.zero());
    estrellasElement.size = sizeEstrellas;
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
      //print("eliminada");
    }


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
        shape,
        //density: 10.0,
        //friction: 0.2,
        restitution:5,

    );
    cuerpo.createFixture(fixtureDef);
    return cuerpo;

  }

  //ESTA FUNCION SIRVE PARA CUANDO ESTA EN CONTACTO//

void beginContact(Object other, Contact contact) {
    if (other is FighterBody || other is GotaBody) {
      hit();

      print("esta en contacto");
    }
  }

}




class EstrellasElement extends SpriteComponent with HasGameRef<PixelWars> {

  EstrellasElement({ super.position})
      : super(size: Vector2.all(64), anchor: Anchor.center);


  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();

    final platformImage = game.images.fromCache('star.png');
    sprite = Sprite(platformImage);

    add(RectangleHitbox()
      ..collisionType = CollisionType.passive);
    //final Image spriteImage;
    //
  }


}



