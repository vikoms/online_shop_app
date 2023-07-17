part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class OnGetProductEvent extends HomeEvent {
  final String category;
  OnGetProductEvent(this.category);

  @override
  List<Object> get props => [category];
}

class OnGetCategoryEvent extends HomeEvent {
  OnGetCategoryEvent();

  @override
  List<Object> get props => [];
}

class OnSelectedCategoryEvent extends HomeEvent {
  final String category;
  OnSelectedCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}
