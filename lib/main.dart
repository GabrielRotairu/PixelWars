import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:juego1/Scenes/KombatGame.dart';

void main() {
  KombatGame kombatGame = KombatGame();
  GameWidget gameWidget = GameWidget(game: kombatGame);

  runApp(gameWidget);
}
