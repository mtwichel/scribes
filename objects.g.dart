import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  const Menu({
    this.id,
    this.menuGroupsIds,
  });

  /// Converts a [Map<String,dynamic>] to a [Menu]
  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    id: json['id'],
    menuGroupsIds: List.from(json['menuGroupsIds'])
          .map((elem) => elem)
          .toList(),
  );

  /// The id of the menu in guid format.
  final String id;

  /// A list of the ids for the menu groups that are contained in this group
  final List<String> menuGroupsIds;

  @override
  List<Object> get props => [
    id,
    menuGroupsIds,
  ];

  /// Converts a [Menu] to a [Map<String,dynamic>]
  Map<String, dynamic> toJson() => {
    'id': id,
    'menuGroupsIds': menuGroupsIds,
  };
}


class Customer extends Equatable {
  const Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.creditCards,
  });

  /// Converts a [Map<String,dynamic>] to a [Customer]
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json['id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    emailAddress: json['emailAddress'],
    creditCards: List.from(json['creditCards'])
          .map((elem) => CreditCard.fromJson(elem))
          .toList(),
  );

  /// The unique guid for this customer. Matches the id from Firebase Auth.
  final String id;

  /// The first name of the customer.
  final String firstName;

  /// The last name of the customer.
  final String lastName;

  /// The email address of the customer.
  final String emailAddress;

  /// Cards saved to the customer's profile.
  final List<CreditCard> creditCards;

  @override
  List<Object> get props => [
    id,
    firstName,
    lastName,
    emailAddress,
    creditCards,
  ];

  /// Converts a [Customer] to a [Map<String,dynamic>]
  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'emailAddress': emailAddress,
    'creditCards': creditCards,
  };
}


class CreditCard extends Equatable {
  const CreditCard({
    this.id,
    this.type,
  });

  /// Converts a [Map<String,dynamic>] to a [CreditCard]
  factory CreditCard.fromJson(Map<String, dynamic> json) => CreditCard(
    id: json['id'],
    type: _cardTypeFromJson(json['type']),
  );

  /// The unique id of the credit card.
  final String id;

  /// Whether the card is a debit or credit card.
  final CardType type;

  @override
  List<Object> get props => [
    id,
    type,
  ];

  /// Converts a [CreditCard] to a [Map<String,dynamic>]
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': _cardTypeToJson(type),
  };
}


class Location extends Equatable {
  const Location({
    this.id,
    this.amenities,
  });

  /// Converts a [Map<String,dynamic>] to a [Location]
  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json['id'],
    amenities: List.from(json['amenities'])
          .map((elem) => _amenityFromJson(elem))
          .toList(),
  );

  /// The unique id of the location in guid format.
  final String id;

  /// The customer facing features of a location.
  final List<Amenity> amenities;

  @override
  List<Object> get props => [
    id,
    amenities,
  ];

  /// Converts a [Location] to a [Map<String,dynamic>]
  Map<String, dynamic> toJson() => {
    'id': id,
    'amenities': amenities,
  };
}


/// A feature of a location.
enum Amenity {
  /// The location has a public restroom.
  restroom,

  /// The location has a drive thru.
  driveThru,

  /// An unrecognized value for `Amenity`.
  unknown,

}

  /// Converts a [Amenity] to a [String]
String _amenityToJson(Amenity input) {
  switch(input) {
    case Amenity.restroom:
      return 'RESTROOM';
    case Amenity.driveThru:
      return 'DRIVE_THRU';
    default:
      return 'UNKNOWN';
  }
}

  /// Converts a [String] to a [Amenity]
Amenity _amenityFromJson(String input) {
  switch(input) {
    case 'RESTROOM':
      return Amenity.restroom;
    case 'DRIVE_THRU':
      return Amenity.driveThru;
    default:
      return Amenity.unknown;
  }
}


/// Whether a card is a debit or credit card.
enum CardType {
  /// A credit card.
  credit,

  /// A debit card.
  debit,

  /// An unrecognized value for `CardType`.
  unknown,

}

  /// Converts a [CardType] to a [String]
String _cardTypeToJson(CardType input) {
  switch(input) {
    case CardType.credit:
      return 'CREDIT';
    case CardType.debit:
      return 'DEBIT';
    default:
      return 'UNKNOWN';
  }
}

  /// Converts a [String] to a [CardType]
CardType _cardTypeFromJson(String input) {
  switch(input) {
    case 'CREDIT':
      return CardType.credit;
    case 'DEBIT':
      return CardType.debit;
    default:
      return CardType.unknown;
  }
}


