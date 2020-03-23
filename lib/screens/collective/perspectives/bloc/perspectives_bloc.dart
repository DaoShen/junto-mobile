import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/backend/backend.dart';
import 'package:junto_beta_mobile/filters/bloc/channel_filtering_bloc.dart';
import 'package:junto_beta_mobile/models/expression_query_params.dart';
import 'package:junto_beta_mobile/models/perspective.dart';
import 'package:junto_beta_mobile/screens/collective/bloc/collective_bloc.dart';
import 'package:junto_beta_mobile/utils/junto_exception.dart';

part 'perspectives_event.dart';
part 'perspectives_state.dart';

class PerspectivesBloc extends Bloc<PerspectivesEvent, PerspectivesState> {
  PerspectivesBloc(this.userRepository, this.userDataProvider);

  final UserRepo userRepository;
  final UserDataProvider userDataProvider;

  @override
  PerspectivesState get initialState => PerspectivesInitial();

  @override
  Stream<PerspectivesState> mapEventToState(
    PerspectivesEvent event,
  ) async* {
    if (event is FetchPerspectives) {
      yield* _mapFetchToState(event);
    }
    if (event is RemovePerspective) {
      // TODO: move logic of removing perspectives to bloc
    }
    if (event is ChangePerspective) {
      //
    }
    if (event is CreatePerspective) {
      //
    }
  }

  Future<List<PerspectiveModel>> _fetchUserPerspectives(String address) async {
    try {
      return await userRepository.getUserPerspective(address);
    } on JuntoException catch (error) {
      debugPrint('error fethcing perspectives ${error.errorCode}');
      return null;
    }
  }

  Stream<PerspectivesState> _mapFetchToState(FetchPerspectives event) async* {
    try {
      final address = userDataProvider.userAddress;
      final persp = await _fetchUserPerspectives(address);
      if (persp != null) {
        yield PerspectivesFetched(persp);
      } else {
        yield PerspectivesError();
      }
    } catch (e) {
      yield PerspectivesError();
    }
  }

  void change(PerspectiveModel perspective, CollectiveBloc bloc,
      ChannelFilteringBloc filteringBloc) {
    if (perspective.name == 'JUNTO') {
      bloc.add(
        FetchCollective(
          ExpressionQueryParams(
            contextType: ExpressionContextType.Collective,
            name: perspective.name,
          ),
        ),
      );
    } else if (perspective.name == 'Connections') {
      bloc.add(
        FetchCollective(
          ExpressionQueryParams(
            contextType: ExpressionContextType.ConnectPerspective,
            dos: '0',
            context: perspective.address,
            name: perspective.name,
          ),
        ),
      );
    } else {
      bloc.add(
        FetchCollective(
          ExpressionQueryParams(
            contextType: ExpressionContextType.FollowPerspective,
            dos: null,
            context: perspective.address,
            name: perspective.name.contains("'s Follow Perspective")
                ? 'Subscriptions'
                : perspective.name,
          ),
        ),
      );
    }
    filteringBloc.add(FilterClear());
  }
}
