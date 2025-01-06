part of 'poster_bloc.dart';

abstract class PosterEvent extends Equatable {
  const PosterEvent();

  @override
  List<Object?> get props => [];
}

class FetchPostersEvent extends PosterEvent {}
