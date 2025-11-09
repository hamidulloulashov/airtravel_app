// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accommodation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccommodationState {
  Status get status;
  AccommodationModel? get accommodation;
  String? get errorMessage;

  /// Create a copy of AccommodationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AccommodationStateCopyWith<AccommodationState> get copyWith =>
      _$AccommodationStateCopyWithImpl<AccommodationState>(
          this as AccommodationState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AccommodationState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accommodation, accommodation) ||
                other.accommodation == accommodation) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, accommodation, errorMessage);

  @override
  String toString() {
    return 'AccommodationState(status: $status, accommodation: $accommodation, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $AccommodationStateCopyWith<$Res> {
  factory $AccommodationStateCopyWith(
          AccommodationState value, $Res Function(AccommodationState) _then) =
      _$AccommodationStateCopyWithImpl;
  @useResult
  $Res call(
      {Status status, AccommodationModel? accommodation, String? errorMessage});
}

/// @nodoc
class _$AccommodationStateCopyWithImpl<$Res>
    implements $AccommodationStateCopyWith<$Res> {
  _$AccommodationStateCopyWithImpl(this._self, this._then);

  final AccommodationState _self;
  final $Res Function(AccommodationState) _then;

  /// Create a copy of AccommodationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? accommodation = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      accommodation: freezed == accommodation
          ? _self.accommodation
          : accommodation // ignore: cast_nullable_to_non_nullable
              as AccommodationModel?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AccommodationState].
extension AccommodationStatePatterns on AccommodationState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AccommodationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccommodationState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AccommodationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccommodationState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AccommodationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccommodationState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(Status status, AccommodationModel? accommodation,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AccommodationState() when $default != null:
        return $default(_that.status, _that.accommodation, _that.errorMessage);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(Status status, AccommodationModel? accommodation,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccommodationState():
        return $default(_that.status, _that.accommodation, _that.errorMessage);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(Status status, AccommodationModel? accommodation,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AccommodationState() when $default != null:
        return $default(_that.status, _that.accommodation, _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AccommodationState implements AccommodationState {
  const _AccommodationState(
      {required this.status, this.accommodation, this.errorMessage});

  @override
  final Status status;
  @override
  final AccommodationModel? accommodation;
  @override
  final String? errorMessage;

  /// Create a copy of AccommodationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AccommodationStateCopyWith<_AccommodationState> get copyWith =>
      __$AccommodationStateCopyWithImpl<_AccommodationState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AccommodationState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accommodation, accommodation) ||
                other.accommodation == accommodation) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, accommodation, errorMessage);

  @override
  String toString() {
    return 'AccommodationState(status: $status, accommodation: $accommodation, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$AccommodationStateCopyWith<$Res>
    implements $AccommodationStateCopyWith<$Res> {
  factory _$AccommodationStateCopyWith(
          _AccommodationState value, $Res Function(_AccommodationState) _then) =
      __$AccommodationStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Status status, AccommodationModel? accommodation, String? errorMessage});
}

/// @nodoc
class __$AccommodationStateCopyWithImpl<$Res>
    implements _$AccommodationStateCopyWith<$Res> {
  __$AccommodationStateCopyWithImpl(this._self, this._then);

  final _AccommodationState _self;
  final $Res Function(_AccommodationState) _then;

  /// Create a copy of AccommodationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? accommodation = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_AccommodationState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      accommodation: freezed == accommodation
          ? _self.accommodation
          : accommodation // ignore: cast_nullable_to_non_nullable
              as AccommodationModel?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
