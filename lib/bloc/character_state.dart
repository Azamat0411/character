import 'package:character/data/character.dart';

abstract class CharacterState{
}

class CharacterLoading extends CharacterState{

}

class CharacterLoaded extends CharacterState{
  final List loadedChar;
  CharacterLoaded({required this.loadedChar});
}

class CharacterError extends CharacterState{

}