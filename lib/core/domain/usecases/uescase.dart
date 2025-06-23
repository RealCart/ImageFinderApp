abstract interface class Usecase<T, P> {
  Future<T> call({required P params});
}

class NoParams {}
