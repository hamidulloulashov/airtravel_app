// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BaseState {
  Status get status;
  String? get errorMessage;
  List<RegionModel> get regions;

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BaseStateCopyWith<BaseState> get copyWith =>
      _$BaseStateCopyWithImpl<BaseState>(this as BaseState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BaseState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other.regions, regions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, errorMessage,
      const DeepCollectionEquality().hash(regions));

  @override
  String toString() {
    return 'BaseState(status: $status, errorMessage: $errorMessage, regions: $regions)';
  }
}

/// @nodoc
abstract mixin class $BaseStateCopyWith<$Res> {
  factory $BaseStateCopyWith(BaseState value, $Res Function(BaseState) _then) =
      _$BaseStateCopyWithImpl;
  @useResult
  $Res call({Status status, String? errorMessage, List<RegionModel> regions});
}

/// @nodoc
class _$BaseStateCopyWithImpl<$Res> implements $BaseStateCopyWith<$Res> {
  _$BaseStateCopyWithImpl(this._self, this._then);

  final BaseState _self;
  final $Res Function(BaseState) _then;

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? regions = null,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      regions: null == regions
          ? _self.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<RegionModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BaseState].
extension BaseStatePatterns on BaseState {
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
    TResult Function(_BaseState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BaseState() when $default != null:
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
    TResult Function(_BaseState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseState():
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
    TResult? Function(_BaseState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseState() when $default != null:
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
    TResult Function(
            Status status, String? errorMessage, List<RegionModel> regions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BaseState() when $default != null:
        return $default(_that.status, _that.errorMessage, _that.regions);
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
    TResult Function(
            Status status, String? errorMessage, List<RegionModel> regions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseState():
        return $default(_that.status, _that.errorMessage, _that.regions);
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
    TResult? Function(
            Status status, String? errorMessage, List<RegionModel> regions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BaseState() when $default != null:
        return $default(_that.status, _that.errorMessage, _that.regions);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BaseState implements BaseState {
  _BaseState(
      {required this.status,
      this.errorMessage,
      required final List<RegionModel> regions})
      : _regions = regions;

  @override
  final Status status;
  @override
  final String? errorMessage;
  final List<RegionModel> _regions;
  @override
  List<RegionModel> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BaseStateCopyWith<_BaseState> get copyWith =>
      __$BaseStateCopyWithImpl<_BaseState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BaseState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._regions, _regions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, errorMessage,
      const DeepCollectionEquality().hash(_regions));

  @override
  String toString() {
    return 'BaseState(status: $status, errorMessage: $errorMessage, regions: $regions)';
  }
}

/// @nodoc
abstract mixin class _$BaseStateCopyWith<$Res>
    implements $BaseStateCopyWith<$Res> {
  factory _$BaseStateCopyWith(
          _BaseState value, $Res Function(_BaseState) _then) =
      __$BaseStateCopyWithImpl;
  @override
  @useResult
  $Res call({Status status, String? errorMessage, List<RegionModel> regions});
}

/// @nodoc
class __$BaseStateCopyWithImpl<$Res> implements _$BaseStateCopyWith<$Res> {
  __$BaseStateCopyWithImpl(this._self, this._then);

  final _BaseState _self;
  final $Res Function(_BaseState) _then;

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? regions = null,
  }) {
    return _then(_BaseState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      regions: null == regions
          ? _self._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<RegionModel>,
    ));
  }
}

// dart format on
