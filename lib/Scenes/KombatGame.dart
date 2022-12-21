import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:juego1/Players/Player1.dart';
import 'package:flame/game.dart';

class KombatGame extends Forge2DGame {
  late TiledComponent mapComponent;

  KombatGame() : super(gravity: Vector2(0, 9.8), zoom: 1);

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();

    mapComponent = await TiledComponent.load('mapa1.tmx', Vector2.all(32));
    add(mapComponent);
/*
    final capaObjGroup = mapComponent.tileMap.getLayer<ObjectGroup>('objetos');

    for (final obj in capaObjGroup!.objects) {
      addTiledObjectCollision(obj);
    }*/

    Fighter fighter =
        Fighter(position: Vector2(size.x / 3, 0), size: size * 0.1);
    add(fighter);
  }

  void addTiledObjectCollision(TiledObject tiledObject) {
    //DEFINO PRIMERO EL CUERPO Y NO LA FORMA
    final bodyDef = BodyDef()
      ..position = Vector2(tiledObject.x, tiledObject.y)
      ..type = BodyType.static;
    Body body = world.createBody(bodyDef);

    //DEFINO LA FORMA

    if (tiledObject.isPolygon) {
      ChainShape shape = ChainShape();

      final List<Vector2> vertices = [];
      for (final polygon in tiledObject.polygon) {
        shape.vertices.add(Vector2(polygon.x, polygon.y));
      }
      final fixtureDef = FixtureDef(shape)
        ..userData = this // To be able to determine object in collision
        ..restitution = 0.8
        ..density = 1.0
        ..friction = 0.2;

      body.createFixture(fixtureDef);
    } else if (tiledObject.isRectangle) {
      print("DEBUG: ---->>>> " + tiledObject.x.toString());
      final shape = PolygonShape();

      final vertices = [
        Vector2(0, 0),
        Vector2(tiledObject.width, 0),
        Vector2(tiledObject.width, tiledObject.height),
        Vector2(0, tiledObject.height),
      ];
      shape.set(vertices);

      final fixtureDef = FixtureDef(shape)
        ..userData = this // To be able to determine object in collision
        ..restitution = 0.8
        ..density = 1.0
        ..friction = 0.2;

      body.createFixture(fixtureDef);
    }
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return const Color.fromRGBO(104, 129, 255, 1.0);
  }
}
