// Status of a permission request to use location services.
enum PermissionStatus {
  /// The permission to use location services has been granted.
  granted,

  /// The permission to use location services has been denied by the user. May
  /// have been denied forever on iOS.
  denied,


  deniedForever
}