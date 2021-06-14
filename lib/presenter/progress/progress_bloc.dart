import 'package:assessment_bcg_telkomsel/presenter/progress/progress_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressInitial());

  @override
  Stream<ProgressState> mapEventToState(ProgressEvent event) async* {
    if (event is UpdateProgress) {
      yield ProgressLoaded(position: event.position);
    }
  }
}
