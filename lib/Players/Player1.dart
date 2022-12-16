import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';


class Player extends SpriteComponent with Tappable{
  static final _paint = Paint();
  Color cVisible=Colors.blue;
  double iYMovido=0;
  double iYOrigen=0;
  int tapCount=0;
  int iLevel=1;
  int iDireccion=-2;
  int iAlturaMaxima=800;
  double dGravedad=9.8;
  late Rect rectObjecto;
  late dynamic imgNave;
  final imagesLoader = Images();
  late Offset imgOffset;
  //SpriteAnimation a;

  //late Sprite spriteNave;

  @override
  Future<void>? onLoad() async {
    // TODO: implement onLoad
    iYOrigen=position[1];
    rectObjecto=size.toRect();

    imgNave = (await imagesLoader.load('naves/nave1.jpg'));
    imgOffset = const Offset( 0,0);
    sprite = Sprite(imgNave);

    //spriteNave = Sprite(imgNave,srcSize: size);
    //sprite = (await imagesLoader.load('naves/nave1.jpg'));
    //add(spriteNave);
    //imgNave=Image.asset("assets/icon/icon.png");
    return super.onLoad();

  }

  //UNO
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    _paint.color = cVisible;
    position[1]=position[1]+iDireccion;

    if(position[1]<0){
      iDireccion=-iDireccion;
    }
    if(position[1]>iAlturaMaxima){
      iDireccion=-iDireccion;
    }


    //position[1]=iYOrigen+iYMovido;
  }

  //DOS
  @override
  void render(Canvas canvas) {
    //a.re
    //sprite?.renderRect(canvas, rectObjecto);
    //sprite.render(canvas, 16.0, 16.0);
    //canvas.drawRect(rectObjecto, _paint);
    //super.render(canvas);


    //canvas.drawImage(imgNave,imgOffset, _paint);
    //spriteNave.render(canvas,size: Vector2(400.0, y=400.0));
    //canvas.drawImage(image, offset, paint)
  }

  @override
  bool onTapUp(TapUpInfo info) {
    print("tap up");
    cVisible = Colors.green;
    return true;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // TODO: implement onTapDown
    cVisible = Colors.red;
    iDireccion=-iDireccion;
    /*tapCount++;
    if(tapCount>iLevel*5){
      iDireccion=iDireccion*2;
      tapCount=0;
    }*/
    //iYMovido=iYMovido+10;
    return super.onTapDown(info);
  }



}