typedef FutureOptional<T> = Future<Optional<T>>;

sealed class Optional<T> {
  const Optional();
  static Optional<T> from<T>(T? value) {
    return value == null ? None() : Some(value: value);
  }

  const factory Optional.some({required T value}) = Some<T>;
  const factory Optional.none() = None<T>;
}

final class Some<T> extends Optional<T> {
  final T value;
  const Some({required this.value});

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) => other is Some<T> && other.value == value;

  @override
  String toString() => 'Some(value: $value)';
}

final class None<T> extends Optional<T> {
  const None();

  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) => other is None<T>;

  @override
  String toString() => 'None()';
}
