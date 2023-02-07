import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:juego1/Scenes/PixelWars.dart';

void main() {
  PixelWars pixelWars= PixelWars();
  GameWidget gameWidget = GameWidget(game: pixelWars);

  runApp(gameWidget);
}
