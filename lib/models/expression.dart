import 'package:flutter/cupertino.dart';
import 'package:junto_beta_mobile/backend/backend.dart';
import 'package:junto_beta_mobile/models/user_model.dart';
import 'package:junto_beta_mobile/utils/utils.dart';

/// Base class for posting an expression to the server
class CentralizedExpression {
  CentralizedExpression({
    @required this.type,
    @required this.expressionData,
    this.channels: const <String>[],
    this.context,
  });

  factory CentralizedExpression.fromMap(Map<String, dynamic> map) {
    return CentralizedExpression(
      type: map['type'] as String,
      channels: List<String>.from(map['channels']),
      expressionData: map['expression_data'] as Map<String, dynamic>,
      context: map['context'] as Map<String, dynamic>,
    );
  }

  /// Type of expression being created. Server currently supports  LongForm,
  /// ShortForm, PhotoForm, EventForm.
  final String type;

  /// Map representation of the expression. Values are dependant on [type].
  /// Can be serialized to an object:
  /// * [CentralizedLongFormExpression],
  /// * [CentralizedShortFormExpression]
  /// * [CentralizedPhotoFormExpression]
  /// * [CentralizedEventFormExpression]
  final Map<String, dynamic> expressionData;

  /// Context for the given expression. Value is dependant on [ExpressionContext].
  /// See docs for details: https://github.com/juntofoundation/Junto-Alpha-API/blob/master/docs/expression.md
  final dynamic context;

  /// list of channel UUIDs the expression will be shared to.
  final List<String> channels;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'expression_data': expressionData,
      'context': context,
      'channels': channels,
    };
  }

  CentralizedExpression copyWith({
    String type,
    Map<String, dynamic> expressionData,
    dynamic context,
    List<String> channels = const <String>[],
  }) {
    return CentralizedExpression(
      type: type ?? this.type,
      expressionData: expressionData ?? this.expressionData,
      context: context ?? this.context,
      channels: channels ?? this.channels,
    );
  }
}

class CentralizedLongFormExpression {
  CentralizedLongFormExpression({
    this.title,
    this.body,
  });

  factory CentralizedLongFormExpression.fromMap(Map<String, dynamic> json) {
    return CentralizedLongFormExpression(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  final String title;
  final String body;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'body': body,
      };
}

class CentralizedShortFormExpression {
  CentralizedShortFormExpression({
    @required this.background,
    @required this.body,
  });

  factory CentralizedShortFormExpression.fromMap(Map<String, dynamic> json) {
    return CentralizedShortFormExpression(
      background: json['background'],
      body: json['body'],
    );
  }

  final String background;
  final String body;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'background': background,
        'body': body,
      };
}

class CentralizedPhotoFormExpression {
  CentralizedPhotoFormExpression({
    this.image,
    this.caption,
  });

  factory CentralizedPhotoFormExpression.fromMap(Map<String, dynamic> json) {
    return CentralizedPhotoFormExpression(
      image: json['image'],
      caption: json['caption'],
    );
  }

  String image;
  String caption;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'image': image,
        'caption': caption,
      };
}

class CentralizedEventFormExpression {
  CentralizedEventFormExpression({
    this.title,
    this.description,
    this.photo,
    this.location,
    this.startTime,
    this.endTime,
    this.facilitators,
    this.members
  });

  factory CentralizedEventFormExpression.fromMap(Map<String, dynamic> json) {
    return CentralizedEventFormExpression(
      title: json['title'],
      description: json['description'],
      photo: json['photo'],
      location: json['location'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    facilitators: json['facilitators'],
    members: json['members']);      
    

  }

  final String title;
  final String description;
  final String photo;
  final String location;
  final String startTime;
  final String endTime;
  final List<String> facilitators;
  final List<String> members;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'title': title,
        'description': description,
        'photo': photo,
        'location': location,
        'start_time': startTime,
        'end_time': endTime,
        'facilitators': facilitators,
        'members': members
      };
}

class CentralizedExpressionResponse {
  CentralizedExpressionResponse(
      {this.address,
      this.type,
      this.expressionData,
      this.createdAt,
      this.numberResonations,
      this.creator,
      this.context,
      this.privacy,
      this.comments = 0,
      this.resonations = 0});

  factory CentralizedExpressionResponse.withCommentsAndResonations(
      Map<String, dynamic> json) {
    return CentralizedExpressionResponse(
      address: json['address'],
      type: json['type'],
      expressionData: generateExpressionData(
        json['type'],
        json['expression_data'],
      ),
      createdAt: RFC3339.parseRfc3339(
        json['created_at'],
      ),
      numberResonations: json['resonations'] as int,
      creator: UserProfile.fromMap(
        json['creator'],
      ),
      privacy: json['privacy'] ?? '',
      context: json['context'] ?? '',
      comments: json['comments'],
      resonations: json['resonations'] as int,
    );
  }

  factory CentralizedExpressionResponse.fromMap(Map<String, dynamic> json) {
    return CentralizedExpressionResponse(
      address: json['address'],
      type: json['type'],
      expressionData: generateExpressionData(
        json['type'],
        json['expression_data'],
      ),
      createdAt: RFC3339.parseRfc3339(
        json['created_at'],
      ),
      numberResonations: json['resonations'] ?? 0,
      creator: UserProfile.fromMap(
        json['creator'],
      ),
      privacy: json['privacy'] ?? '',
      context: json['context'] ?? '',
      comments: json['comments'] as int,
    );
  }

  final String address;
  final String type;
  final dynamic expressionData;
  final DateTime createdAt;
  final int numberResonations;
  final int comments;
  final int resonations;
  final String privacy;
  final String context;
  final UserProfile creator;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'type': type,
      'expression_data': expressionData.toJson(),
      'created_at': createdAt.toIso8601String(),
      'resonations': numberResonations,
      'creator': creator.toMap(),
      'privacy': privacy ?? '',
      'context': context ?? '',
    };
  }

  static dynamic generateExpressionData(
      String type, Map<String, dynamic> json) {
    if (type == 'LongForm') {
      return CentralizedLongFormExpression.fromMap(json);
    }
    if (type == 'ShortForm') {
      return CentralizedShortFormExpression.fromMap(json);
    }
    if (type == 'PhotoForm') {
      return CentralizedPhotoFormExpression.fromMap(json);
    }
    if (type == 'EventForm') {
      return CentralizedEventFormExpression.fromMap(json);
    }
  }
}

class Comment {
  Comment({
    this.address,
    this.type,
    this.expressionData,
    this.creator,
    this.comments,
    this.resonations,
    this.createdAt,
    this.privacy,
    this.context,
  });

  factory Comment.fromMap(Map<String, dynamic> json) {
    return Comment(
      address: json['address'],
      type: json['type'],
      expressionData: CentralizedExpressionResponse.generateExpressionData(
        json['type'],
        json['expression_data'],
      ),
      creator: UserProfile.fromMap(json['creator']),
      comments: json['comments'],
      resonations: json['resonations'],
      createdAt: RFC3339.parseRfc3339(json['created_at']),
      privacy: json['privacy'],
      context: json['context'],
    );
  }

  final String address;
  final String type;
  final dynamic expressionData;
  final UserProfile creator;
  final int comments;
  final int resonations;
  final DateTime createdAt;
  final String privacy;
  final String context;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'address': address,
        'type': type,
        'expression_data': expressionData.toJson(),
        'creator': creator.toMap(),
        'comments': comments,
        'resonations': resonations,
        'created_at': createdAt.toIso8601String(),
        'privacy': privacy,
        'context': context,
      };
}

class ExpressionQueryParams {
  ExpressionQueryParams({
    @required this.dos,
    @required this.context,
    @required this.channels,
    @required this.contextType,
    @required this.paginationPos,
  });

  final int dos;
  final int context;
  final List<String> channels;
  final ExpressionContextType contextType;
  final int paginationPos;
}

enum ExpressionContextType { dos, perspective, random, collective }

/// Encapsulates the response sent back from the server after querying an
/// expression.
class QueryExpressionResults {
  QueryExpressionResults({
    @required this.results,
    @required this.lastTimestamp,
  });

  final List<CentralizedExpressionResponse> results;
  final String lastTimestamp;
}

/// Encapsulates the response sent back from the server after querying a
/// comment.
class QueryCommentResults {
  QueryCommentResults({
    @required this.results,
    @required this.lastTimestamp,
  });

  final List<Comment> results;
  final String lastTimestamp;
}
