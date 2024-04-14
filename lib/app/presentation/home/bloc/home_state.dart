part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {}

final class HomeSuccess extends HomeState {
  final int atualPage;
  final int? maxPage;
  final bool isLoading;
  final String? searchTerm;
  final List<CharacterEntity> characters;
  final List<CharacterEntity>? filteredCharacters;

  const HomeSuccess({
    this.atualPage = 1,
    this.maxPage,
    this.isLoading = false,
    this.searchTerm,
    required this.characters,
    this.filteredCharacters,
  });

  HomeSuccess copyWith({
    int? atualPage,
    int? maxPage,
    bool? isLoading,
    String? searchTerm,
    List<CharacterEntity>? characters,
    List<CharacterEntity>? filteredCharacters,
  }) {
    return HomeSuccess(
      atualPage: atualPage ?? this.atualPage,
      maxPage: maxPage ?? this.maxPage,
      isLoading: isLoading ?? this.isLoading,
      searchTerm: searchTerm ?? this.searchTerm,
      characters: characters ?? this.characters,
      filteredCharacters: filteredCharacters ?? this.filteredCharacters,
    );
  }

  @override
  List<Object?> get props => [
        atualPage,
        maxPage,
        isLoading,
        searchTerm,
        characters,
        filteredCharacters,
      ];
}
