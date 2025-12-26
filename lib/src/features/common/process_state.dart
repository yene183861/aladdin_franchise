import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'process_state.freezed.dart';

// enum PageCommonState {
//   normal,
//   loading,
//   success,
//   error,
// }

@freezed
class ProcessState with _$ProcessState {
  const factory ProcessState({
    @Default(StatusEnum.normal) StatusEnum status,
    @Default('') String message,
  }) = _ProcessState;
}
