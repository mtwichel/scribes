/** A broad group of menu items organized into menu groups. */
export interface Menu {
  /** The id of the menu in guid format. */
  id: string;

  /** A list of the ids for the menu groups that are contained in this group */
  menuGroupsIds: string[];

}

/** A type guard to determine if an input is a Menu. */
export function isAMenu(input: any): input is Menu {
  return (
    input &&
    typeof input.id === "string" &&
    (Array.isArray(input.menuGroupsIds) &&
    input.menuGroupsIds.every((elem) => typeof input.elem === "string"))
  );
}


/** The customer object as returned by Firestore. */
export interface Customer {
  /** The unique guid for this customer. Matches the id from Firebase Auth. */
  id: string;

  /** The first name of the customer. */
  firstName: string;

  /** The last name of the customer. */
  lastName: string;

  /** The email address of the customer. */
  emailAddress: string;

  /** Cards saved to the customer's profile. */
  creditCards: CreditCard[];

}

/** A type guard to determine if an input is a Customer. */
export function isACustomer(input: any): input is Customer {
  return (
    input &&
    typeof input.id === "string" &&
    typeof input.firstName === "string" &&
    typeof input.lastName === "string" &&
    typeof input.emailAddress === "string" &&
    (Array.isArray(input.creditCards) &&
    input.creditCards.every((elem) => isACreditCard(elem)))
  );
}


/** A credit card or debit card that can be added to a customer's profile. */
export interface CreditCard {
  /** The unique id of the credit card. */
  id: string;

  /** Whether the card is a debit or credit card. */
  type: CardType;

}

/** A type guard to determine if an input is a CreditCard. */
export function isACreditCard(input: any): input is CreditCard {
  return (
    input &&
    typeof input.id === "string" &&
    isACardType(input.type)
  );
}


/** A physical place that sells product. */
export interface Location {
  /** The unique id of the location in guid format. */
  id: string;

  /** The customer facing features of a location. */
  amenities: Amenity[];

}

/** A type guard to determine if an input is a Location. */
export function isALocation(input: any): input is Location {
  return (
    input &&
    typeof input.id === "string" &&
    (Array.isArray(input.amenities) &&
    input.amenities.every((elem) => isAAmenity(elem)))
  );
}


/** A feature of a location. */
export const enum Amenity {
  /** The location has a public restroom. */
  restroom = 'RESTROOM',

  /** The location has a drive thru. */
  driveThru = 'DRIVE_THRU',

}

/** A type guard to determine if an input is a Amenity. */
export function isAAmenity(input: any): input is Amenity {
  return (
    typeof input === "string" && (
    input === "RESTROOM" ||
    input === "DRIVE_THRU"
    )
  );
}


/** Whether a card is a debit or credit card. */
export const enum CardType {
  /** A credit card. */
  credit = 'CREDIT',

  /** A debit card. */
  debit = 'DEBIT',

}

/** A type guard to determine if an input is a CardType. */
export function isACardType(input: any): input is CardType {
  return (
    typeof input === "string" && (
    input === "CREDIT" ||
    input === "DEBIT"
    )
  );
}


