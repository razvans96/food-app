enum UserProfileStatus {
  complete,
  incomplete,
  notFound,
}

extension UserProfileStatusExtension on UserProfileStatus {
  
  bool get exists => this != UserProfileStatus.notFound;
  
  bool get needsCompletion => this == UserProfileStatus.incomplete;
  
  bool get isReady => this == UserProfileStatus.complete;
  
}
