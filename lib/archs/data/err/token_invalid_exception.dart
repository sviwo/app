

import 'http_error_exception.dart';

class TokenInvalidException extends HttpErrorException {
  TokenInvalidException(int code, String msg): super(code: code.toString(), message: msg);
}