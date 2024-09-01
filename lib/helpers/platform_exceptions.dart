class OPlatformException implements Exception {
  final String code;

  // Constructor que captura codigo de error
  OPlatformException(this.code);

  String get message {
    switch (code) {
      case "TimeoutException":
        return "Excepción de tiempo de espera";
      case "invalid-login-credentials":
        return "Invalid login credentials. Please check your information";
      case "too-many-requests":
        return "Too-many-requests. Please try again later";
      case "invalid-argument":
        return "Invalid argument provided.";
      case "invalid-password":
        return "Incorrect password.";
      case "invalid-phone-number":
        return "The provided phone number is invalid.";
      case "operation-not-allowed":
        return "Operation not allowed.";
      case "session-cookie-expired":
        return "uid-already-exists. Please Sign In again.";
      case "uid-already-exists":
        return "uid-already-exists. The provided user ID is already in use by another user.";
      case "sign-in-failed":
        return "sign-in-failed. Please try again.";
      case "network-request-failed":
        return "network-request-failed. Please check your internal connection.";
      case "internal-error":
        return "internal-error. Please try again later.";
      case "invalid-verification-code":
        return "invalid-verification-code. Please enter a valid code.";
      case "invalid-verification-id":
        return "invalid-verification-id. Please request a new verification code.";
      case "quota-exceeded":
        return "Quota exceeded. Plaease try again later.";
      default:
        return "An unexpected platform error ocurred. Please try again.";
    }
  }
}
