
enum UserAuthStatus {
  authenticated,
  notAuthenticated,
}

extension UserAuthStatusExtension on UserAuthStatus {
  
  bool get requiresAuthentication => this == UserAuthStatus.notAuthenticated;
  
  bool get authenticated => this == UserAuthStatus.authenticated;
  
}
