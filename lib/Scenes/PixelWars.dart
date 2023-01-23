import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:juego1/Bodies/Suelo.dart';
import 'package:juego1/Players/GotaPlayer.dart';
import 'package:juego1/Players/Player1.dart';

class PixelWars extends Forge2DGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late TiledComponent mapComponent;
  int verticalDirection = 0;
  int horizontalDirection = 0;

  PixelWars() : super(gravity: Vector2(0, 9.8), zoom: 0.9);

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    await images.loadAll([
      'ember.png',
      'star.png',
      'water_enemy.png',
    ]);
    mapComponent = await TiledComponent.load('mapa3.tmx', Vector2.all(32));
    add(mapComponent);

    ObjectGroup? estrellas =
        mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");
    ObjectGroup? gotas =
        mapComponent.tileMap.getLayer<ObjectGroup>("posIniPlayer2");
    ObjectGroup? posInicial =
        mapComponent.tileMap.getLayer<ObjectGroup>("posIniPlayer");
    ObjectGroup? suelos =
        mapComponent.tileMap.getLayer<ObjectGroup>("mapcollision");

    for (final suelo in suelos!.objects) {
      add(Suelo(tiledBody: suelo));
    }
    for (final estrella in estrellas!.objects) {
      SpriteComponent estrellaComp = SpriteComponent.fromImage(
          images.fromCache("star.png"),
          position: Vector2(estrella.x, estrella.y),
          anchor: Anchor.bottomCenter);
      add(estrellaComp);
    }
    for (final gota in gotas!.objects) {
      Gota player2 = Gota(position: Vector2(gota.x, gota.y));
      add(player2);
    }
    FighterBody player1 = FighterBody(
        position:
            Vector2(posInicial!.objects.first.x, posInicial!.objects.first.y));
    add(player1);
  }

  void setDirection(int horizontalDirection, int verticalDirection) {
    this.horizontalDirection = horizontalDirection;
    this.verticalDirection = verticalDirection;
  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return const Color.fromRGBO(189, 255, 253, 1.0);
  }
}
