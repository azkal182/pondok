part of 'poster_bloc.dart';

abstract class PosterState extends Equatable {
  const PosterState();

  @override
  List<Object?> get props => [];
}

class PosterInitial extends PosterState {}

class PosterLoading extends PosterState {}

class PosterLoaded extends PosterState {
  final List<Poster> posters;

  const PosterLoaded(this.posters);

  @override
  List<Object?> get props => [posters];
}

class PosterError extends PosterState {
  final String message;

  const PosterError(this.message);

  @override
  List<Object?> get props => [message];
}
