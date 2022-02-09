import 'package:character/bloc/character_event.dart';
import 'package:character/bloc/character_state.dart';
import 'package:character/repository/character_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState>{
  final CharacterRepo _characterRepo;
  final int page;

  CharacterBloc(this._characterRepo, this.page) : super(CharacterLoading()){
    on<CharacterEventFetch>((event, emit) async{
      emit(CharacterLoading());
      try{
        List _character = await _characterRepo.getCharacter(page);
        emit(CharacterLoaded(loadedChar: _character));
      }catch (_){
        throw Exception(_);
      }
    });
  }
}