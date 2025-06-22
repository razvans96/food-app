
enum UserAuthStatus {

  notAuthenticated,
  profileIncomplete,
  ready,

}

extension UserAuthStatusExtension on UserAuthStatus {
  
  bool get requiresAuthentication => this == UserAuthStatus.notAuthenticated;
  
  bool get canUseApp => this == UserAuthStatus.ready;
  
  String get routeName {
    switch (this) {
      case UserAuthStatus.notAuthenticated:
      case UserAuthStatus.ready:
        return '/query';
      case UserAuthStatus.profileIncomplete:
        return '/register';
    }
  }
  
}
