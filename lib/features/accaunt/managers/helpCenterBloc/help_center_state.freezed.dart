// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'help_center_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HelpCenterState {
  Status get status;
  String? get errorMessage;
  List<HelpCenterModel> get contacts;

  /// Create a copy of HelpCenterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HelpCenterStateCopyWith<HelpCenterState> get copyWith =>
      _$HelpCenterStateCopyWithImpl<HelpCenterState>(
          this as HelpCenterState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HelpCenterState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other.contacts, contacts));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, errorMessage,
      const DeepCollectionEquality().hash(contacts));

  @override
  String toString() {
    return 'HelpCenterState(status: $status, errorMessage: $errorMessage, contacts: $contacts)';
  }
}

/// @nodoc
abstract mixin class $HelpCenterStateCopyWith<$Res> {
  factory $HelpCenterStateCopyWith(
          HelpCenterState value, $Res Function(HelpCenterState) _then) =
      _$HelpCenterStateCopyWithImpl;
  @useResult
  $Res call(
      {Status status, String? errorMessage, List<HelpCenterModel> contacts});
}

/// @nodoc
class _$HelpCenterStateCopyWithImpl<$Res>
    implements $HelpCenterStateCopyWith<$Res> {
  _$HelpCenterStateCopyWithImpl(this._self, this._then);

  final HelpCenterState _self;
  final $Res Function(HelpCenterState) _then;

  /// Create a copy of HelpCenterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? contacts = null,
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
      contacts: null == contacts
          ? _self.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<HelpCenterModel>,
    ));
  }
}

/// Adds pattern-matching-related methods to [HelpCenterState].
extension HelpCenterStatePatterns on HelpCenterState {
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
    TResult Function(_HelpCenterState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HelpCenterState() when $default != null:
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
    TResult Function(_HelpCenterState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HelpCenterState():
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
    TResult? Function(_HelpCenterState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HelpCenterState() when $default != null:
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
    TResult Function(Status status, String? errorMessage,
            List<HelpCenterModel> contacts)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HelpCenterState() when $default != null:
        return $default(_that.status, _that.errorMessage, _that.contacts);
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
            Status status, String? errorMessage, List<HelpCenterModel> contacts)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HelpCenterState():
        return $default(_that.status, _that.errorMessage, _that.contacts);
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
    TResult? Function(Status status, String? errorMessage,
            List<HelpCenterModel> contacts)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HelpCenterState() when $default != null:
        return $default(_that.status, _that.errorMessage, _that.contacts);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HelpCenterState implements HelpCenterState {
  const _HelpCenterState(
      {required this.status,
      this.errorMessage,
      required final List<HelpCenterModel> contacts})
      : _contacts = contacts;

  @override
  final Status status;
  @override
  final String? errorMessage;
  final List<HelpCenterModel> _contacts;
  @override
  List<HelpCenterModel> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  /// Create a copy of HelpCenterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HelpCenterStateCopyWith<_HelpCenterState> get copyWith =>
      __$HelpCenterStateCopyWithImpl<_HelpCenterState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HelpCenterState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, errorMessage,
      const DeepCollectionEquality().hash(_contacts));

  @override
  String toString() {
    return 'HelpCenterState(status: $status, errorMessage: $errorMessage, contacts: $contacts)';
  }
}

/// @nodoc
abstract mixin class _$HelpCenterStateCopyWith<$Res>
    implements $HelpCenterStateCopyWith<$Res> {
  factory _$HelpCenterStateCopyWith(
          _HelpCenterState value, $Res Function(_HelpCenterState) _then) =
      __$HelpCenterStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Status status, String? errorMessage, List<HelpCenterModel> contacts});
}

/// @nodoc
class __$HelpCenterStateCopyWithImpl<$Res>
    implements _$HelpCenterStateCopyWith<$Res> {
  __$HelpCenterStateCopyWithImpl(this._self, this._then);

  final _HelpCenterState _self;
  final $Res Function(_HelpCenterState) _then;

  /// Create a copy of HelpCenterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? errorMessage = freezed,
    Object? contacts = null,
  }) {
    return _then(_HelpCenterState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      contacts: null == contacts
          ? _self._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<HelpCenterModel>,
    ));
  }
}

// dart format on
