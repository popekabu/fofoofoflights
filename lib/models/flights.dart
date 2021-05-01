// To parse this JSON data, do
//
//     final flights = flightsFromJson(jsonString);

import 'dart:convert';

Flights flightsFromJson(String str) => Flights.fromJson(json.decode(str));

String flightsToJson(Flights data) => json.encode(data.toJson());

class Flights {
  Flights({
    this.groupedItineraryResponse,
  });

  GroupedItineraryResponse groupedItineraryResponse;

  factory Flights.fromJson(Map<String, dynamic> json) => Flights(
    groupedItineraryResponse: GroupedItineraryResponse.fromJson(json["groupedItineraryResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "groupedItineraryResponse": groupedItineraryResponse.toJson(),
  };
}

class GroupedItineraryResponse {
  GroupedItineraryResponse({
    this.version,
    this.messages,
    this.statistics,
    this.scheduleDescs,
    this.taxDescs,
    this.taxSummaryDescs,
    this.obFeeDescs,
    this.fareComponentDescs,
    this.validatingCarrierDescs,
    this.baggageAllowanceDescs,
    this.legDescs,
    this.itineraryGroups,
  });

  String version;
  List<Message> messages;
  Statistics statistics;
  List<ScheduleDesc> scheduleDescs;
  List<TaxDesc> taxDescs;
  List<TaxDesc> taxSummaryDescs;
  List<ObFeeDesc> obFeeDescs;
  List<FareComponentDesc> fareComponentDescs;
  List<ValidatingCarrierDesc> validatingCarrierDescs;
  List<BaggageAllowanceDesc> baggageAllowanceDescs;
  List<LegDesc> legDescs;
  List<ItineraryGroup> itineraryGroups;

  factory GroupedItineraryResponse.fromJson(Map<String, dynamic> json) => GroupedItineraryResponse(
    version: json["version"],
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    statistics: Statistics.fromJson(json["statistics"]),
    scheduleDescs: List<ScheduleDesc>.from(json["scheduleDescs"].map((x) => ScheduleDesc.fromJson(x))),
    taxDescs: List<TaxDesc>.from(json["taxDescs"].map((x) => TaxDesc.fromJson(x))),
    taxSummaryDescs: List<TaxDesc>.from(json["taxSummaryDescs"].map((x) => TaxDesc.fromJson(x))),
    obFeeDescs: List<ObFeeDesc>.from(json["obFeeDescs"].map((x) => ObFeeDesc.fromJson(x))),
    fareComponentDescs: List<FareComponentDesc>.from(json["fareComponentDescs"].map((x) => FareComponentDesc.fromJson(x))),
    validatingCarrierDescs: List<ValidatingCarrierDesc>.from(json["validatingCarrierDescs"].map((x) => ValidatingCarrierDesc.fromJson(x))),
    baggageAllowanceDescs: List<BaggageAllowanceDesc>.from(json["baggageAllowanceDescs"].map((x) => BaggageAllowanceDesc.fromJson(x))),
    legDescs: List<LegDesc>.from(json["legDescs"].map((x) => LegDesc.fromJson(x))),
    itineraryGroups: List<ItineraryGroup>.from(json["itineraryGroups"].map((x) => ItineraryGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    "statistics": statistics.toJson(),
    "scheduleDescs": List<dynamic>.from(scheduleDescs.map((x) => x.toJson())),
    "taxDescs": List<dynamic>.from(taxDescs.map((x) => x.toJson())),
    "taxSummaryDescs": List<dynamic>.from(taxSummaryDescs.map((x) => x.toJson())),
    "obFeeDescs": List<dynamic>.from(obFeeDescs.map((x) => x.toJson())),
    "fareComponentDescs": List<dynamic>.from(fareComponentDescs.map((x) => x.toJson())),
    "validatingCarrierDescs": List<dynamic>.from(validatingCarrierDescs.map((x) => x.toJson())),
    "baggageAllowanceDescs": List<dynamic>.from(baggageAllowanceDescs.map((x) => x.toJson())),
    "legDescs": List<dynamic>.from(legDescs.map((x) => x.toJson())),
    "itineraryGroups": List<dynamic>.from(itineraryGroups.map((x) => x.toJson())),
  };
}

class BaggageAllowanceDesc {
  BaggageAllowanceDesc({
    this.id,
    this.pieceCount,
  });

  int id;
  int pieceCount;

  factory BaggageAllowanceDesc.fromJson(Map<String, dynamic> json) => BaggageAllowanceDesc(
    id: json["id"],
    pieceCount: json["pieceCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pieceCount": pieceCount,
  };
}

class FareComponentDesc {
  FareComponentDesc({
    this.id,
    this.governingCarrier,
    this.fareAmount,
    this.fareCurrency,
    this.fareBasisCode,
    this.farePassengerType,
    this.publishedFareAmount,
    this.mileageSurcharge,
    this.mileage,
    this.directionality,
    this.direction,
    this.notValidAfter,
    this.applicablePricingCategories,
    this.vendorCode,
    this.fareTypeBitmap,
    this.fareType,
    this.fareTariff,
    this.fareRule,
    this.cabinCode,
    this.segments,
    this.notValidBefore,
  });

  int id;
  String governingCarrier;
  int fareAmount;
  String fareCurrency;
  String fareBasisCode;
  String farePassengerType;
  int publishedFareAmount;
  int mileageSurcharge;
  bool mileage;
  String directionality;
  String direction;
  DateTime notValidAfter;
  String applicablePricingCategories;
  String vendorCode;
  String fareTypeBitmap;
  String fareType;
  String fareTariff;
  String fareRule;
  String cabinCode;
  List<FareComponentDescSegment> segments;
  DateTime notValidBefore;

  factory FareComponentDesc.fromJson(Map<String, dynamic> json) => FareComponentDesc(
    id: json["id"],
    governingCarrier: json["governingCarrier"],
    fareAmount: json["fareAmount"],
    fareCurrency: json["fareCurrency"],
    fareBasisCode: json["fareBasisCode"],
    farePassengerType: json["farePassengerType"],
    publishedFareAmount: json["publishedFareAmount"],
    mileageSurcharge: json["mileageSurcharge"] == null ? null : json["mileageSurcharge"],
    mileage: json["mileage"] == null ? null : json["mileage"],
    directionality: json["directionality"],
    direction: json["direction"],
    notValidAfter: DateTime.parse(json["notValidAfter"]),
    applicablePricingCategories: json["applicablePricingCategories"],
    vendorCode: json["vendorCode"],
    fareTypeBitmap: json["fareTypeBitmap"],
    fareType: json["fareType"],
    fareTariff: json["fareTariff"],
    fareRule: json["fareRule"],
    cabinCode: json["cabinCode"],
    segments: List<FareComponentDescSegment>.from(json["segments"].map((x) => FareComponentDescSegment.fromJson(x))),
    notValidBefore: json["notValidBefore"] == null ? null : DateTime.parse(json["notValidBefore"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "governingCarrier": governingCarrier,
    "fareAmount": fareAmount,
    "fareCurrency": fareCurrency,
    "fareBasisCode": fareBasisCode,
    "farePassengerType": farePassengerType,
    "publishedFareAmount": publishedFareAmount,
    "mileageSurcharge": mileageSurcharge == null ? null : mileageSurcharge,
    "mileage": mileage == null ? null : mileage,
    "directionality": directionality,
    "direction": direction,
    "notValidAfter": "${notValidAfter.year.toString().padLeft(4, '0')}-${notValidAfter.month.toString().padLeft(2, '0')}-${notValidAfter.day.toString().padLeft(2, '0')}",
    "applicablePricingCategories": applicablePricingCategories,
    "vendorCode": vendorCode,
    "fareTypeBitmap": fareTypeBitmap,
    "fareType": fareType,
    "fareTariff": fareTariff,
    "fareRule": fareRule,
    "cabinCode": cabinCode,
    "segments": List<dynamic>.from(segments.map((x) => x.toJson())),
    "notValidBefore": notValidBefore == null ? null : "${notValidBefore.year.toString().padLeft(4, '0')}-${notValidBefore.month.toString().padLeft(2, '0')}-${notValidBefore.day.toString().padLeft(2, '0')}",
  };
}

class FareComponentDescSegment {
  FareComponentDescSegment({
    this.segment,
  });

  PurpleSegment segment;

  factory FareComponentDescSegment.fromJson(Map<String, dynamic> json) => FareComponentDescSegment(
    segment: PurpleSegment.fromJson(json["segment"]),
  );

  Map<String, dynamic> toJson() => {
    "segment": segment.toJson(),
  };
}

class PurpleSegment {
  PurpleSegment({
    this.extraMileageAllowance,
    this.surcharges,
  });

  bool extraMileageAllowance;
  List<Surcharge> surcharges;

  factory PurpleSegment.fromJson(Map<String, dynamic> json) => PurpleSegment(
    extraMileageAllowance: json["extraMileageAllowance"] == null ? null : json["extraMileageAllowance"],
    surcharges: json["surcharges"] == null ? null : List<Surcharge>.from(json["surcharges"].map((x) => Surcharge.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "extraMileageAllowance": extraMileageAllowance == null ? null : extraMileageAllowance,
    "surcharges": surcharges == null ? null : List<dynamic>.from(surcharges.map((x) => x.toJson())),
  };
}

class Surcharge {
  Surcharge({
    this.amount,
    this.currency,
    this.description,
    this.type,
  });

  double amount;
  String currency;
  String description;
  String type;

  factory Surcharge.fromJson(Map<String, dynamic> json) => Surcharge(
    amount: json["amount"].toDouble(),
    currency: json["currency"],
    description: json["description"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "description": description,
    "type": type,
  };
}

class ItineraryGroup {
  ItineraryGroup({
    this.groupDescription,
    this.itineraries,
  });

  GroupDescription groupDescription;
  List<Itinerary> itineraries;

  factory ItineraryGroup.fromJson(Map<String, dynamic> json) => ItineraryGroup(
    groupDescription: GroupDescription.fromJson(json["groupDescription"]),
    itineraries: List<Itinerary>.from(json["itineraries"].map((x) => Itinerary.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "groupDescription": groupDescription.toJson(),
    "itineraries": List<dynamic>.from(itineraries.map((x) => x.toJson())),
  };
}

class GroupDescription {
  GroupDescription({
    this.legDescriptions,
  });

  List<LegDescription> legDescriptions;

  factory GroupDescription.fromJson(Map<String, dynamic> json) => GroupDescription(
    legDescriptions: List<LegDescription>.from(json["legDescriptions"].map((x) => LegDescription.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "legDescriptions": List<dynamic>.from(legDescriptions.map((x) => x.toJson())),
  };
}

class LegDescription {
  LegDescription({
    this.departureDate,
    this.departureLocation,
    this.arrivalLocation,
  });

  DateTime departureDate;
  String departureLocation;
  String arrivalLocation;

  factory LegDescription.fromJson(Map<String, dynamic> json) => LegDescription(
    departureDate: DateTime.parse(json["departureDate"]),
    departureLocation: json["departureLocation"],
    arrivalLocation: json["arrivalLocation"],
  );

  Map<String, dynamic> toJson() => {
    "departureDate": "${departureDate.year.toString().padLeft(4, '0')}-${departureDate.month.toString().padLeft(2, '0')}-${departureDate.day.toString().padLeft(2, '0')}",
    "departureLocation": departureLocation,
    "arrivalLocation": arrivalLocation,
  };
}

class Itinerary {
  Itinerary({
    this.id,
    this.pricingSource,
    this.legs,
    this.pricingInformation,
    this.diversitySwapper,
  });

  int id;
  String pricingSource;
  List<Leg> legs;
  List<PricingInformation> pricingInformation;
  DiversitySwapper diversitySwapper;

  factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
    id: json["id"],
    pricingSource: json["pricingSource"],
    legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    pricingInformation: List<PricingInformation>.from(json["pricingInformation"].map((x) => PricingInformation.fromJson(x))),
    diversitySwapper: DiversitySwapper.fromJson(json["diversitySwapper"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pricingSource": pricingSource,
    "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
    "pricingInformation": List<dynamic>.from(pricingInformation.map((x) => x.toJson())),
    "diversitySwapper": diversitySwapper.toJson(),
  };
}

class DiversitySwapper {
  DiversitySwapper({
    this.weighedPrice,
  });

  double weighedPrice;

  factory DiversitySwapper.fromJson(Map<String, dynamic> json) => DiversitySwapper(
    weighedPrice: json["weighedPrice"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "weighedPrice": weighedPrice,
  };
}

class Leg {
  Leg({
    this.ref,
  });

  int ref;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    ref: json["ref"],
  );

  Map<String, dynamic> toJson() => {
    "ref": ref,
  };
}

class PricingInformation {
  PricingInformation({
    this.pricingSubsource,
    this.fare,
  });

  String pricingSubsource;
  Fare fare;

  factory PricingInformation.fromJson(Map<String, dynamic> json) => PricingInformation(
    pricingSubsource: json["pricingSubsource"],
    fare: Fare.fromJson(json["fare"]),
  );

  Map<String, dynamic> toJson() => {
    "pricingSubsource": pricingSubsource,
    "fare": fare.toJson(),
  };
}

class Fare {
  Fare({
    this.validatingCarrierCode,
    this.vita,
    this.eTicketable,
    this.governingCarriers,
    this.passengerInfoList,
    this.totalFare,
    this.validatingCarriers,
    this.lastTicketDate,
    this.lastTicketTime,
  });

  String validatingCarrierCode;
  bool vita;
  bool eTicketable;
  String governingCarriers;
  List<PassengerInfoList> passengerInfoList;
  TotalFare totalFare;
  List<Leg> validatingCarriers;
  DateTime lastTicketDate;
  String lastTicketTime;

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
    validatingCarrierCode: json["validatingCarrierCode"],
    vita: json["vita"],
    eTicketable: json["eTicketable"],
    governingCarriers: json["governingCarriers"],
    passengerInfoList: List<PassengerInfoList>.from(json["passengerInfoList"].map((x) => PassengerInfoList.fromJson(x))),
    totalFare: TotalFare.fromJson(json["totalFare"]),
    validatingCarriers: List<Leg>.from(json["validatingCarriers"].map((x) => Leg.fromJson(x))),
    lastTicketDate: json["lastTicketDate"] == null ? null : DateTime.parse(json["lastTicketDate"]),
    lastTicketTime: json["lastTicketTime"] == null ? null : json["lastTicketTime"],
  );

  Map<String, dynamic> toJson() => {
    "validatingCarrierCode": validatingCarrierCode,
    "vita": vita,
    "eTicketable": eTicketable,
    "governingCarriers": governingCarriers,
    "passengerInfoList": List<dynamic>.from(passengerInfoList.map((x) => x.toJson())),
    "totalFare": totalFare.toJson(),
    "validatingCarriers": List<dynamic>.from(validatingCarriers.map((x) => x.toJson())),
    "lastTicketDate": lastTicketDate == null ? null : "${lastTicketDate.year.toString().padLeft(4, '0')}-${lastTicketDate.month.toString().padLeft(2, '0')}-${lastTicketDate.day.toString().padLeft(2, '0')}",
    "lastTicketTime": lastTicketTime == null ? null : lastTicketTime,
  };
}

class PassengerInfoList {
  PassengerInfoList({
    this.passengerInfo,
  });

  PassengerInfo passengerInfo;

  factory PassengerInfoList.fromJson(Map<String, dynamic> json) => PassengerInfoList(
    passengerInfo: PassengerInfo.fromJson(json["passengerInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "passengerInfo": passengerInfo.toJson(),
  };
}

class PassengerInfo {
  PassengerInfo({
    this.passengerType,
    this.passengerNumber,
    this.nonRefundable,
    this.fareComponents,
    this.taxes,
    this.taxSummaries,
    this.currencyConversion,
    this.passengerTotalFare,
    this.baggageInformation,
    this.obFees,
  });

  String passengerType;
  int passengerNumber;
  bool nonRefundable;
  List<FareComponent> fareComponents;
  List<Leg> taxes;
  List<Leg> taxSummaries;
  CurrencyConversion currencyConversion;
  PassengerTotalFare passengerTotalFare;
  List<BaggageInformation> baggageInformation;
  List<Leg> obFees;

  factory PassengerInfo.fromJson(Map<String, dynamic> json) => PassengerInfo(
    passengerType: json["passengerType"],
    passengerNumber: json["passengerNumber"],
    nonRefundable: json["nonRefundable"],
    fareComponents: List<FareComponent>.from(json["fareComponents"].map((x) => FareComponent.fromJson(x))),
    taxes: List<Leg>.from(json["taxes"].map((x) => Leg.fromJson(x))),
    taxSummaries: List<Leg>.from(json["taxSummaries"].map((x) => Leg.fromJson(x))),
    currencyConversion: CurrencyConversion.fromJson(json["currencyConversion"]),
    passengerTotalFare: PassengerTotalFare.fromJson(json["passengerTotalFare"]),
    baggageInformation: List<BaggageInformation>.from(json["baggageInformation"].map((x) => BaggageInformation.fromJson(x))),
    obFees: json["obFees"] == null ? null : List<Leg>.from(json["obFees"].map((x) => Leg.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "passengerType": passengerType,
    "passengerNumber": passengerNumber,
    "nonRefundable": nonRefundable,
    "fareComponents": List<dynamic>.from(fareComponents.map((x) => x.toJson())),
    "taxes": List<dynamic>.from(taxes.map((x) => x.toJson())),
    "taxSummaries": List<dynamic>.from(taxSummaries.map((x) => x.toJson())),
    "currencyConversion": currencyConversion.toJson(),
    "passengerTotalFare": passengerTotalFare.toJson(),
    "baggageInformation": List<dynamic>.from(baggageInformation.map((x) => x.toJson())),
    "obFees": obFees == null ? null : List<dynamic>.from(obFees.map((x) => x.toJson())),
  };
}

class BaggageInformation {
  BaggageInformation({
    this.provisionType,
    this.airlineCode,
    this.segments,
    this.allowance,
  });

  String provisionType;
  String airlineCode;
  List<BaggageInformationSegment> segments;
  Leg allowance;

  factory BaggageInformation.fromJson(Map<String, dynamic> json) => BaggageInformation(
    provisionType: json["provisionType"],
    airlineCode: json["airlineCode"],
    segments: List<BaggageInformationSegment>.from(json["segments"].map((x) => BaggageInformationSegment.fromJson(x))),
    allowance: Leg.fromJson(json["allowance"]),
  );

  Map<String, dynamic> toJson() => {
    "provisionType": provisionType,
    "airlineCode": airlineCode,
    "segments": List<dynamic>.from(segments.map((x) => x.toJson())),
    "allowance": allowance.toJson(),
  };
}

class BaggageInformationSegment {
  BaggageInformationSegment({
    this.id,
  });

  int id;

  factory BaggageInformationSegment.fromJson(Map<String, dynamic> json) => BaggageInformationSegment(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}

class CurrencyConversion {
  CurrencyConversion({
    this.from,
    this.to,
    this.exchangeRateUsed,
  });

  String from;
  String to;
  int exchangeRateUsed;

  factory CurrencyConversion.fromJson(Map<String, dynamic> json) => CurrencyConversion(
    from: json["from"],
    to: json["to"],
    exchangeRateUsed: json["exchangeRateUsed"],
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "exchangeRateUsed": exchangeRateUsed,
  };
}

class FareComponent {
  FareComponent({
    this.ref,
    this.segments,
  });

  int ref;
  List<FareComponentSegment> segments;

  factory FareComponent.fromJson(Map<String, dynamic> json) => FareComponent(
    ref: json["ref"],
    segments: List<FareComponentSegment>.from(json["segments"].map((x) => FareComponentSegment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ref": ref,
    "segments": List<dynamic>.from(segments.map((x) => x.toJson())),
  };
}

class FareComponentSegment {
  FareComponentSegment({
    this.segment,
  });

  FluffySegment segment;

  factory FareComponentSegment.fromJson(Map<String, dynamic> json) => FareComponentSegment(
    segment: FluffySegment.fromJson(json["segment"]),
  );

  Map<String, dynamic> toJson() => {
    "segment": segment.toJson(),
  };
}

class FluffySegment {
  FluffySegment({
    this.bookingCode,
    this.cabinCode,
    this.seatsAvailable,
    this.mealCode,
    this.availabilityBreak,
  });

  String bookingCode;
  String cabinCode;
  int seatsAvailable;
  String mealCode;
  bool availabilityBreak;

  factory FluffySegment.fromJson(Map<String, dynamic> json) => FluffySegment(
    bookingCode: json["bookingCode"],
    cabinCode: json["cabinCode"],
    seatsAvailable: json["seatsAvailable"],
    mealCode: json["mealCode"] == null ? null : json["mealCode"],
    availabilityBreak: json["availabilityBreak"] == null ? null : json["availabilityBreak"],
  );

  Map<String, dynamic> toJson() => {
    "bookingCode": bookingCode,
    "cabinCode": cabinCode,
    "seatsAvailable": seatsAvailable,
    "mealCode": mealCode == null ? null : mealCode,
    "availabilityBreak": availabilityBreak == null ? null : availabilityBreak,
  };
}

class PassengerTotalFare {
  PassengerTotalFare({
    this.totalFare,
    this.totalTaxAmount,
    this.currency,
    this.baseFareAmount,
    this.baseFareCurrency,
    this.equivalentAmount,
    this.equivalentCurrency,
    this.constructionAmount,
    this.constructionCurrency,
    this.commissionPercentage,
    this.commissionAmount,
    this.exchangeRateOne,
  });

  double totalFare;
  double totalTaxAmount;
  String currency;
  int baseFareAmount;
  String baseFareCurrency;
  int equivalentAmount;
  String equivalentCurrency;
  double constructionAmount;
  String constructionCurrency;
  int commissionPercentage;
  int commissionAmount;
  int exchangeRateOne;

  factory PassengerTotalFare.fromJson(Map<String, dynamic> json) => PassengerTotalFare(
    totalFare: json["totalFare"].toDouble(),
    totalTaxAmount: json["totalTaxAmount"].toDouble(),
    currency: json["currency"],
    baseFareAmount: json["baseFareAmount"],
    baseFareCurrency: json["baseFareCurrency"],
    equivalentAmount: json["equivalentAmount"],
    equivalentCurrency: json["equivalentCurrency"],
    constructionAmount: json["constructionAmount"].toDouble(),
    constructionCurrency: json["constructionCurrency"],
    commissionPercentage: json["commissionPercentage"],
    commissionAmount: json["commissionAmount"],
    exchangeRateOne: json["exchangeRateOne"],
  );

  Map<String, dynamic> toJson() => {
    "totalFare": totalFare,
    "totalTaxAmount": totalTaxAmount,
    "currency": currency,
    "baseFareAmount": baseFareAmount,
    "baseFareCurrency": baseFareCurrency,
    "equivalentAmount": equivalentAmount,
    "equivalentCurrency": equivalentCurrency,
    "constructionAmount": constructionAmount,
    "constructionCurrency": constructionCurrency,
    "commissionPercentage": commissionPercentage,
    "commissionAmount": commissionAmount,
    "exchangeRateOne": exchangeRateOne,
  };
}

class TotalFare {
  TotalFare({
    this.totalPrice,
    this.totalTaxAmount,
    this.currency,
    this.baseFareAmount,
    this.baseFareCurrency,
    this.constructionAmount,
    this.constructionCurrency,
    this.equivalentAmount,
    this.equivalentCurrency,
  });

  double totalPrice;
  double totalTaxAmount;
  String currency;
  int baseFareAmount;
  String baseFareCurrency;
  double constructionAmount;
  String constructionCurrency;
  int equivalentAmount;
  String equivalentCurrency;

  factory TotalFare.fromJson(Map<String, dynamic> json) => TotalFare(
    totalPrice: json["totalPrice"].toDouble(),
    totalTaxAmount: json["totalTaxAmount"].toDouble(),
    currency: json["currency"],
    baseFareAmount: json["baseFareAmount"],
    baseFareCurrency: json["baseFareCurrency"],
    constructionAmount: json["constructionAmount"].toDouble(),
    constructionCurrency: json["constructionCurrency"],
    equivalentAmount: json["equivalentAmount"],
    equivalentCurrency: json["equivalentCurrency"],
  );

  Map<String, dynamic> toJson() => {
    "totalPrice": totalPrice,
    "totalTaxAmount": totalTaxAmount,
    "currency": currency,
    "baseFareAmount": baseFareAmount,
    "baseFareCurrency": baseFareCurrency,
    "constructionAmount": constructionAmount,
    "constructionCurrency": constructionCurrency,
    "equivalentAmount": equivalentAmount,
    "equivalentCurrency": equivalentCurrency,
  };
}

class LegDesc {
  LegDesc({
    this.id,
    this.elapsedTime,
    this.schedules,
  });

  int id;
  int elapsedTime;
  List<Schedule> schedules;

  factory LegDesc.fromJson(Map<String, dynamic> json) => LegDesc(
    id: json["id"],
    elapsedTime: json["elapsedTime"],
    schedules: List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "elapsedTime": elapsedTime,
    "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
  };
}

class Schedule {
  Schedule({
    this.ref,
    this.departureDateAdjustment,
  });

  int ref;
  int departureDateAdjustment;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    ref: json["ref"],
    departureDateAdjustment: json["departureDateAdjustment"] == null ? null : json["departureDateAdjustment"],
  );

  Map<String, dynamic> toJson() => {
    "ref": ref,
    "departureDateAdjustment": departureDateAdjustment == null ? null : departureDateAdjustment,
  };
}

class Message {
  Message({
    this.severity,
    this.type,
    this.code,
    this.text,
  });

  String severity;
  String type;
  String code;
  String text;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    severity: json["severity"],
    type: json["type"],
    code: json["code"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "severity": severity,
    "type": type,
    "code": code,
    "text": text,
  };
}

class ObFeeDesc {
  ObFeeDesc({
    this.id,
    this.amount,
    this.currency,
  });

  int id;
  int amount;
  String currency;

  factory ObFeeDesc.fromJson(Map<String, dynamic> json) => ObFeeDesc(
    id: json["id"],
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "currency": currency,
  };
}

class ScheduleDesc {
  ScheduleDesc({
    this.id,
    this.frequency,
    this.stopCount,
    this.eTicketable,
    this.totalMilesFlown,
    this.elapsedTime,
    this.departure,
    this.arrival,
    this.carrier,
    this.trafficRestriction,
    this.hiddenStops,
    this.dotRating,
  });

  int id;
  String frequency;
  int stopCount;
  bool eTicketable;
  int totalMilesFlown;
  int elapsedTime;
  Arrival departure;
  Arrival arrival;
  Carrier carrier;
  String trafficRestriction;
  List<HiddenStop> hiddenStops;
  String dotRating;

  factory ScheduleDesc.fromJson(Map<String, dynamic> json) => ScheduleDesc(
    id: json["id"],
    frequency: json["frequency"],
    stopCount: json["stopCount"],
    eTicketable: json["eTicketable"],
    totalMilesFlown: json["totalMilesFlown"],
    elapsedTime: json["elapsedTime"],
    departure: Arrival.fromJson(json["departure"]),
    arrival: Arrival.fromJson(json["arrival"]),
    carrier: Carrier.fromJson(json["carrier"]),
    trafficRestriction: json["trafficRestriction"] == null ? null : json["trafficRestriction"],
    hiddenStops: json["hiddenStops"] == null ? null : List<HiddenStop>.from(json["hiddenStops"].map((x) => HiddenStop.fromJson(x))),
    dotRating: json["dotRating"] == null ? null : json["dotRating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "frequency": frequency,
    "stopCount": stopCount,
    "eTicketable": eTicketable,
    "totalMilesFlown": totalMilesFlown,
    "elapsedTime": elapsedTime,
    "departure": departure.toJson(),
    "arrival": arrival.toJson(),
    "carrier": carrier.toJson(),
    "trafficRestriction": trafficRestriction == null ? null : trafficRestriction,
    "hiddenStops": hiddenStops == null ? null : List<dynamic>.from(hiddenStops.map((x) => x.toJson())),
    "dotRating": dotRating == null ? null : dotRating,
  };
}

class Arrival {
  Arrival({
    this.airport,
    this.city,
    this.state,
    this.country,
    this.time,
    this.dateAdjustment,
    this.terminal,
  });

  String airport;
  String city;
  String state;
  String country;
  String time;
  int dateAdjustment;
  String terminal;

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
    airport: json["airport"],
    city: json["city"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"],
    time: json["time"],
    dateAdjustment: json["dateAdjustment"] == null ? null : json["dateAdjustment"],
    terminal: json["terminal"] == null ? null : json["terminal"],
  );

  Map<String, dynamic> toJson() => {
    "airport": airport,
    "city": city,
    "state": state == null ? null : state,
    "country": country,
    "time": time,
    "dateAdjustment": dateAdjustment == null ? null : dateAdjustment,
    "terminal": terminal == null ? null : terminal,
  };
}

class Carrier {
  Carrier({
    this.marketing,
    this.marketingFlightNumber,
    this.operating,
    this.operatingFlightNumber,
    this.equipment,
    this.disclosure,
    this.alliances,
    this.codeShared,
  });

  String marketing;
  int marketingFlightNumber;
  String operating;
  int operatingFlightNumber;
  Equipment equipment;
  String disclosure;
  String alliances;
  String codeShared;

  factory Carrier.fromJson(Map<String, dynamic> json) => Carrier(
    marketing: json["marketing"],
    marketingFlightNumber: json["marketingFlightNumber"],
    operating: json["operating"],
    operatingFlightNumber: json["operatingFlightNumber"],
    equipment: Equipment.fromJson(json["equipment"]),
    disclosure: json["disclosure"] == null ? null : json["disclosure"],
    alliances: json["alliances"] == null ? null : json["alliances"],
    codeShared: json["codeShared"] == null ? null : json["codeShared"],
  );

  Map<String, dynamic> toJson() => {
    "marketing": marketing,
    "marketingFlightNumber": marketingFlightNumber,
    "operating": operating,
    "operatingFlightNumber": operatingFlightNumber,
    "equipment": equipment.toJson(),
    "disclosure": disclosure == null ? null : disclosure,
    "alliances": alliances == null ? null : alliances,
    "codeShared": codeShared == null ? null : codeShared,
  };
}

class Equipment {
  Equipment({
    this.code,
    this.typeForFirstLeg,
    this.typeForLastLeg,
  });

  String code;
  String typeForFirstLeg;
  String typeForLastLeg;

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
    code: json["code"],
    typeForFirstLeg: json["typeForFirstLeg"],
    typeForLastLeg: json["typeForLastLeg"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "typeForFirstLeg": typeForFirstLeg,
    "typeForLastLeg": typeForLastLeg,
  };
}

class HiddenStop {
  HiddenStop({
    this.airport,
    this.city,
    this.country,
    this.arrivalTime,
    this.departureTime,
    this.airMiles,
    this.elapsedTime,
    this.elapsedLayoverTime,
    this.equipment,
  });

  String airport;
  String city;
  String country;
  String arrivalTime;
  String departureTime;
  int airMiles;
  int elapsedTime;
  int elapsedLayoverTime;
  String equipment;

  factory HiddenStop.fromJson(Map<String, dynamic> json) => HiddenStop(
    airport: json["airport"],
    city: json["city"],
    country: json["country"],
    arrivalTime: json["arrivalTime"],
    departureTime: json["departureTime"],
    airMiles: json["airMiles"],
    elapsedTime: json["elapsedTime"],
    elapsedLayoverTime: json["elapsedLayoverTime"],
    equipment: json["equipment"],
  );

  Map<String, dynamic> toJson() => {
    "airport": airport,
    "city": city,
    "country": country,
    "arrivalTime": arrivalTime,
    "departureTime": departureTime,
    "airMiles": airMiles,
    "elapsedTime": elapsedTime,
    "elapsedLayoverTime": elapsedLayoverTime,
    "equipment": equipment,
  };
}

class Statistics {
  Statistics({
    this.itineraryCount,
  });

  int itineraryCount;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    itineraryCount: json["itineraryCount"],
  );

  Map<String, dynamic> toJson() => {
    "itineraryCount": itineraryCount,
  };
}

class TaxDesc {
  TaxDesc({
    this.id,
    this.code,
    this.amount,
    this.currency,
    this.description,
    this.publishedAmount,
    this.publishedCurrency,
    this.station,
    this.country,
  });

  int id;
  String code;
  double amount;
  String currency;
  String description;
  double publishedAmount;
  String publishedCurrency;
  String station;
  String country;

  factory TaxDesc.fromJson(Map<String, dynamic> json) => TaxDesc(
    id: json["id"],
    code: json["code"],
    amount: json["amount"].toDouble(),
    currency: json["currency"],
    description: json["description"],
    publishedAmount: json["publishedAmount"].toDouble(),
    publishedCurrency: json["publishedCurrency"],
    station: json["station"],
    country: json["country"] == null ? null : json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "amount": amount,
    "currency": currency,
    "description": description,
    "publishedAmount": publishedAmount,
    "publishedCurrency": publishedCurrency,
    "station": station,
    "country": country == null ? null : country,
  };
}

class ValidatingCarrierDesc {
  ValidatingCarrierDesc({
    this.id,
    this.settlementMethod,
    this.newVcxProcess,
    this.validatingCarrierDescDefault,
    this.alternates,
  });

  int id;
  String settlementMethod;
  bool newVcxProcess;
  Default validatingCarrierDescDefault;
  List<Default> alternates;

  factory ValidatingCarrierDesc.fromJson(Map<String, dynamic> json) => ValidatingCarrierDesc(
    id: json["id"],
    settlementMethod: json["settlementMethod"],
    newVcxProcess: json["newVcxProcess"],
    validatingCarrierDescDefault: Default.fromJson(json["default"]),
    alternates: json["alternates"] == null ? null : List<Default>.from(json["alternates"].map((x) => Default.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "settlementMethod": settlementMethod,
    "newVcxProcess": newVcxProcess,
    "default": validatingCarrierDescDefault.toJson(),
    "alternates": alternates == null ? null : List<dynamic>.from(alternates.map((x) => x.toJson())),
  };
}

class Default {
  Default({
    this.code,
  });

  String code;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
  };
}
