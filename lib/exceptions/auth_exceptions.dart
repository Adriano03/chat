class AuthException {
  String emailExists =
      '[firebase_auth/email-already-in-use] The email address is already in use by another account.';
  String emailNotFound =
      '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.';
  String invalidPassword =
      '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.';
  String blockedAccess =
      '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.';
  String disableAccount =
      '[firebase_auth/user-disabled] The user account has been disabled by an administrator.';
  String unformattedEmail =
      '[firebase_auth/invalid-email] The email address is badly formatted.';
  String networkFailed =
      '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
}
