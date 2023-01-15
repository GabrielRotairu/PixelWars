import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:forge2d/src/dynamics/body.dart';
import 'package:juego1/Scenes/PixelWars.dart';

class Suelo extends BodyComponent<PixelWars> {
  TiledObject tiledBody;

  Suelo({required this.tiledBody});

  @override
  Future<void> onLoad() {
    // TODO: implement onLoad
    renderBody = false;
    return super.onLoad();
  }

  @override
  Body createBody() {
    // TODO: implement createBody
    late FixtureDef fixtureDef;

    if (tiledBody.isRectangle) {
      PolygonShape shape = PolygonShape();
      final vertices = [
        Vector2(0, 0),
        Vector2(tiledBody.width, 0),
        Vector2(tiledBody.width, tiledBody.height),
        Vector2(0, tiledBody.height),
      ];
      shape.set(vertices);
      fixtureDef = FixtureDef(shape);



    }   BodyDef definicionCuerpo = BodyDef(
        position: Vector2(tiledBody.x, tiledBody.y), type: BodyType.static);
    Body cuerpo = world.createBody(definicionCuerpo);

    cuerpo.createFixture(fixtureDef);
    return cuerpo;
  }
}
