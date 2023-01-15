import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:juego1/Elements/StarElement.dart';
import 'package:juego1/Players/GotaPlayer.dart';
import 'package:juego1/Players/Player1.dart';

class PixelWars extends Forge2DGame with HasKeyboardHandlerComponents {
  late TiledComponent mapComponent;

  PixelWars();

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

    Fighter player1 = Fighter(position: Vector2(200,0));
    add(player1);


    ObjectGroup?  estrellas = mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");
    ObjectGroup?  gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for (final estrella in estrellas!.objects){

      SpriteComponent estrellaComp = SpriteComponent.fromImage(images.fromCache("star.png"),position: Vector2(estrella.x,estrella.y),anchor: Anchor.bottomCenter);
      add(estrellaComp);


    }
    for (final gota in gotas!.objects){

      Gota gotaComp = Gota(position: Vector2(gota.x,gota.y));
      add(gotaComp);


    }

  }

  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return const Color.fromRGBO(189, 255, 253, 1.0);
  }
}
