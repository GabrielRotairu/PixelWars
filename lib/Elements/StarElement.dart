import 'package:flame/components.dart';
import 'package:juego1/Scenes/PixelWars.dart';

class StarElement extends SpriteComponent with HasGameRef<PixelWars>{

  @override
  Future<void>? onLoad() async{
    // TODO: implement onLoad
    await super.onLoad();


    SpriteComponent component = SpriteComponent.fromImage(game.images.fromCache("star.png"));


    add(component);
  }

}