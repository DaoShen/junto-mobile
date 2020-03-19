import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/backend/repositories.dart';
import 'package:junto_beta_mobile/models/expression_query_params.dart';
import 'package:junto_beta_mobile/models/models.dart';
import 'package:junto_beta_mobile/utils/junto_exception.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'collective_event.dart';
part 'collective_state.dart';

class CollectiveBloc extends Bloc<CollectiveEvent, CollectiveState> {
  CollectiveBloc(this.expressionRepository, this.onUnauthorized);

  final ExpressionRepo expressionRepository;
  final VoidCallback onUnauthorized;
  Map<String, String> _params;
  int _currentPage = 0;
  String _lastTimeStamp;

  @override
  Stream<CollectiveState> transformEvents(
    Stream<CollectiveEvent> events,
    Stream<CollectiveState> Function(CollectiveEvent event) next,
  ) {
    final debounceStream =
        events.debounceTime(const Duration(milliseconds: 1000));
    return super.transformEvents(debounceStream, next);
  }

  @override
  CollectiveState get initialState => CollectiveInitial();

  @override
  Stream<CollectiveState> mapEventToState(
    CollectiveEvent event,
  ) async* {
    if (event is FetchCollective) {
      yield* _mapFetchCollectiveToState(event);
    }
    if (event is FetchMoreCollective) {
      yield* _mapFetchMoreCollectiveToState(event);
    }
    if (event is RefreshCollective) {
      yield* _mapRefreshToState(event);
    }
  }

  Stream<CollectiveState> _mapRefreshToState(RefreshCollective event) async* {
    try {
      yield CollectiveLoading();

      _updateParams(true, null);
      final expressions = await _fetchExpressions();

      yield CollectivePopulated(expressions.results);
    } on JuntoException catch (e, s) {
      handleJuntoException(e, s);
    } catch (e, s) {
      print(e);
      print(s.toString());
      yield CollectiveError();
    }
  }

  Stream<CollectiveState> _mapFetchCollectiveToState(
      FetchCollective event) async* {
    try {
      yield CollectiveLoading();

      _updateParams(true, event.param);
      final expressions = await _fetchExpressions();

      yield CollectivePopulated(expressions.results);
    } on JuntoException catch (e, s) {
      handleJuntoException(e, s);
    } catch (e, s) {
      print(e);
      print(s.toString());
      yield CollectiveError();
    }
  }

  Stream<CollectiveState> _mapFetchMoreCollectiveToState(
    FetchMoreCollective event,
  ) async* {
    try {
      if (_params != null && state is CollectivePopulated) {
        final currentState = state as CollectivePopulated;
        yield CollectivePopulated(currentState.results, true);

        _updateParams(false, null);
        final expressions = await _fetchExpressions();

        final currentResult = currentState.results;
        currentResult.addAll(expressions.results);
        yield CollectivePopulated(currentResult, false);
      }
    } on JuntoException catch (e, s) {
      handleJuntoException(e, s);
    } catch (e, s) {
      print(e);
      print(s.toString());
      yield CollectiveError();
    }
  }

  Future<QueryResults<ExpressionResponse>> _fetchExpressions() async {
    final expressions =
        await expressionRepository.getCollectiveExpressions(_params);
    print(
        'Fetched ${expressions.results.length} expressions from API, last_timestamp: ${expressions.lastTimestamp}');
    _lastTimeStamp = expressions.lastTimestamp;
    return expressions;
  }

  void _updateParams(bool clean, ExpressionQueryParams param) {
    if (clean) {
      //refreshing or fetching from zero
      _lastTimeStamp = null;
      _currentPage = 0;

      _params = <String, String>{
        'context_type': 'Collective',
        // 'context': event.contextString,
        'pagination_position': '$_currentPage',
        if (param?.channels?.isNotEmpty == true)
          'channels[0]': param.channels[0]
      };
    } else {
      // scrolling down
      _params['last_timestamp'] = _lastTimeStamp;
      _params['pagination_position'] =
          (_currentPage = _currentPage + 50).toString();
    }
  }

  void handleJuntoException(JuntoException e, StackTrace s) {
    print('Error during fetching expression ${e.message}: ${e.errorCode}: $s');
    if (e.errorCode == 401) {
      print('Unauthorized, popping to the welcome screen');
      onUnauthorized();
    }
  }
}
