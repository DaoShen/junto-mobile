import 'package:junto_beta_mobile/models/user_model.dart';

/// Expressions are at the center of Junto. Users can choose form Longform,
/// shortform and media.
class Expression {
  Expression({
    this.expression,
    this.subExpressions,
    this.authorUsername,
    this.authorProfile,
    this.resonations,
    this.timestamp,
    this.channels,
  });

  /// Creates an [Expression] from the given map
  factory Expression.fromMap(Map<String, dynamic> json) {
    return Expression(
      expression: ExpressionContent.fromMap(
        json['expression'],
      ),
      subExpressions: List<Expression>.from(
        json['sub_expressions'].map(
          (Map<String, dynamic> expression) => Expression.fromMap(expression),
        ),
      ),
      authorUsername: Username.fromMap(
        json['author_username'],
      ),
      authorProfile: UserProfile.fromMap(
        json['author_profile'],
      ),
      resonations: List<dynamic>.from(
        json['resonations'].map((dynamic resonations) => resonations),
      ),
      timestamp: json['timestamp'],
      channels: List<Channel>.from(
        json['channels'].map(
          (dynamic channel) => Channel.fromMap(channel),
        ),
      ),
    );
  }

  final ExpressionContent expression;

  /// List of expressions associated with the given `Expression`
  final List<Expression> subExpressions;

  /// This field contains the author's address and entry (username)
  final Username authorUsername;

  /// Contains the address and profile information associated with the author.
  final UserProfile authorProfile;

  //TODO(Nash):  Speak to Eric regarding the content of resonations
  final List<dynamic> resonations;

  /// String containing the date
  final String timestamp;

  /// The channel where the expression was posted
  final List<Channel> channels;

  /// Converts the given expression to Map
  Map<String, dynamic> toMap() => <String, dynamic>{
        'expression': expression.toMap(),
        'sub_expressions': List<dynamic>.from(
          subExpressions.map(
            (Expression subExpression) => subExpression.toMap(),
          ),
        ),
        'author_username': authorUsername.toMap(),
        'author_profile': authorProfile.toMap(),
        'resonations': List<dynamic>.from(
          resonations.map((dynamic resonations) => resonations),
        ),
        'timestamp': timestamp,
        'channels': List<dynamic>.from(
          channels.map(
            (Channel channel) => channel.toMap(),
          ),
        ),
      };
}

class Channel {
  Channel({
    this.address,
    this.value,
    this.attributeType,
  });

  factory Channel.fromMap(Map<String, dynamic> json) => Channel(
        address: json['address'],
        attributeType: json['entry']['attribute_type'],
        value: json['entry']['value'],
      );

  /// Location
  final String address;

  /// Channel where the `Expression` was posted
  final String value;

  final String attributeType;

  /// Converts the object to a map
  Map<String, dynamic> toMap() => <String, dynamic>{
        'address': address,
        'entry': <String, String>{
          'value': value,
          'attribute_type': attributeType,
        },
      };
}

/// Contains the type of expression along with the content of the expression.
/// Fields include [title] and [body].
class ExpressionContent {
  ExpressionContent({
    this.address,
    this.expressionContent,
    this.expressionType,
  });

  factory ExpressionContent.fromMap(Map<String, dynamic> json) {
    return ExpressionContent(
      address: json['address'],
      expressionType: json['entry']['expression_type'],
      expressionContent: json['entry']['expression'],
    );
  }

  /// Location
  String address;

  /// The type of [Expression]. Longform or shortform
  final String expressionType;

  /// Contains the content of the expression. Varies depending on
  /// [expressionType]
  final Map<String, dynamic> expressionContent;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'entry': <String, dynamic>{
        'expression_type': expressionType,
        'expression': expressionContent,
      },
    };
  }
}
