import '../../model/loser_model.dart';

abstract class LoserState {
  const LoserState();
}

class LoserInitial extends LoserState {}

class LoserPickImageState extends LoserState {}
class LocationSavedState extends LoserState {}
class CategoryChangedState extends LoserState {}
class LoserLocationLoading extends LoserState {}
class LoserLocationPickedState extends LoserState {}
class LoserUploadLoadingState extends LoserState {}
class LoserUploadSuccessState extends LoserState {}
class LoserDataLoadedState extends LoserState {}
class LoserUploadErrorState extends LoserState {
  final String error;
  LoserUploadErrorState(this.error);
}
class FetchLoserDataLoadingState extends LoserState {}

class FetchLoserDataSuccessState extends LoserState {}
class LoserFilterChanged extends LoserState {}
class LoserSearchLoad extends LoserState {}
class LoserSearchSuccess  extends LoserState {}
class LoserSearchInit  extends LoserState {}
class LoserSearchUpdated  extends LoserState {}
class LoserMyPostsLoaded  extends LoserState {}
class ToGallSuccessState  extends LoserState {}
class RemovePostSuccessState  extends LoserState {}
class FetchLoserDataErrorState extends LoserState {
  final String error;

  FetchLoserDataErrorState(this.error);
}



