class ApiError {

  ApiError({
    this.code,
    this.message,
});
  String? code;
  String? message;

  ApiError copyWith({
    String? code,
    String? message,
})=> ApiError(
    code: code,
    message: message,
  );
}
