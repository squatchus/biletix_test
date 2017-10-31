//
//  BTXGetOptimalFaresParser.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/31/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXGetOptimalFaresParser.h"
#import "BTXFare.h"
#import "BTXFlight.h"
#import "BTXApiConstants.h"

static NSString* const kErrorKeyPath = @"Body.GetOptimalFaresOutput.error";
static NSString* const kCurrencyKeyPath = @"Body.GetOptimalFaresOutput.currency";
static NSString* const kOffersKeyPath = @"Body.GetOptimalFaresOutput.offers";
static NSString* const kDirectionsKeyPath = @"directions.GetOptimalFaresDirection";
static NSString* const kFlightsKeyPath = @"flights.GetOptimalFaresFlight";
static NSString* const kFlightInfoKeyPath = @"segments.AirSegment";

static NSString* const kErrorCodeKey = @"code";
static NSString* const kErrorDescriptionKey = @"description";
static NSString* const kOfferFaresKey = @"GetOptimalFaresOffer";
static NSString* const kOfferLinkKey = @"link";
static NSString* const kFlightLinkKey = @"link";
static NSString* const kTotalPriceKey = @"total_price";
static NSString* const kFlightCarrierKey = @"ak";
static NSString* const kFlightNumberKey = @"flight_number";
static NSString* const kDepartureDateKey = @"departure_date";
static NSString* const kDepartureTimeKey = @"departure_time";
static NSString* const kDepartureAirportKey = @"departure_airport_code";
static NSString* const kArrivalDateKey = @"arrival_date";
static NSString* const kArrivalTimeKey = @"arrival_time";
static NSString* const kArrivalAirportKey = @"arrival_airport_code";

static NSString* const kErrorCodeOKValue = @"OK";

@implementation BTXGetOptimalFaresParser

+ (void)parseResponseDict:(nonnull NSDictionary *)dict
                  success:(nonnull void(^)(NSArray<BTXFare *>* _Nonnull fares))successBlock
                  failure:(nonnull void(^)(NSString* _Nullable error))failureBlock {
    @try {
        NSString *error = [BTXGetOptimalFaresParser errorFromDict:dict];
        if (error) {  failureBlock(error); return; }

        id offers = [dict valueForKeyPath:kOffersKeyPath];
        id offerFares = offers[kOfferFaresKey];
        NSString *currency = [dict valueForKeyPath:kCurrencyKeyPath];
        NSMutableArray *fares = [NSMutableArray new];
        
        for (NSDictionary *offer in offerFares) {
            NSNumber *price = offer[kTotalPriceKey];
            NSString *offerLink = offer[kOfferLinkKey];
            id directions = [offer valueForKeyPath:kDirectionsKeyPath];
            id outboundFlights = [directions[0] valueForKeyPath:kFlightsKeyPath];
            id returnFlights = [directions[1] valueForKeyPath:kFlightsKeyPath];
            NSArray *outboundFlightsParsed = [BTXGetOptimalFaresParser flightsFromSoapNode:outboundFlights];
            NSArray *returnFlightsParsed = [BTXGetOptimalFaresParser flightsFromSoapNode:returnFlights];
            for (BTXFlight *outboundFlight in outboundFlightsParsed)
                for (BTXFlight *returnFlight in returnFlightsParsed) {
                    NSString *fareLink = [@[offerLink, outboundFlight.linkSuffix, returnFlight.linkSuffix] componentsJoinedByString:@""];
                    BTXFare *fare = [[BTXFare alloc] initWithPrice:price currency:currency link:fareLink outboundFlight:outboundFlight returnFlight:returnFlight];
                    [fares addObject:fare];
                }
        }
        successBlock([fares copy]);
    }
    @catch (NSException *exception) {
        failureBlock(BTXErrorParsingFailed);
    }
}

+ (NSArray <BTXFlight *>*)flightsFromSoapNode:(id)node {
    NSMutableArray *flights = [NSMutableArray new];
    if ([node isKindOfClass:[NSDictionary class]])
        [flights addObject:[BTXGetOptimalFaresParser flightFromDict:node]];
    else if ([node isKindOfClass:[NSArray class]]) {
        for (NSDictionary *flight in node)
            [flights addObject:[BTXGetOptimalFaresParser flightFromDict:flight]];
    }
    return [flights copy];
}

+ (BTXFlight *)flightFromDict:(NSDictionary *)dict {
    NSString *link = dict[kFlightLinkKey];
    NSDictionary *flightInfo = [dict valueForKeyPath:kFlightInfoKeyPath];
    NSString *number = [NSString stringWithFormat:@"%@ %@", flightInfo[kFlightCarrierKey], flightInfo[kFlightNumberKey]];
    
    NSString *depAirport = flightInfo[kDepartureAirportKey];
    NSString *arrAirport = flightInfo[kArrivalAirportKey];
    NSString *depDate = flightInfo[kDepartureDateKey];
    NSString *depTime = flightInfo[kDepartureTimeKey];
    NSString *arrDate = flightInfo[kArrivalDateKey];
    NSString *arrTime = flightInfo[kArrivalTimeKey];
    BTXFlight *flight = [[BTXFlight alloc] initWithNumber:number departureDate:depDate departureTime:depTime departureAirport:depAirport arrivalDate:arrDate arrivalTime:arrTime arrivalAirport:arrAirport link:link];
    return flight;
}

+ (NSString *)errorFromDict:(NSDictionary *)dict {
    NSDictionary *errorDict = [dict valueForKeyPath:kErrorKeyPath];
    NSString *errorCode = errorDict[kErrorCodeKey];
    NSString *errorDescription = errorDict[kErrorDescriptionKey];
    if (![errorCode isEqualToString:kErrorCodeOKValue]) return errorDescription;
    
    id offers = [dict valueForKeyPath:kOffersKeyPath];
    if (![offers isKindOfClass:[NSDictionary class]]) return BTXErrorFaresNotFound;
    
    NSArray *fares = offers[kOfferFaresKey];
    if (![fares isKindOfClass:[NSArray class]]) return BTXErrorFaresNotFound;
    
    if (fares.count == 0) return BTXErrorFaresNotFound;
    return nil;
}

@end
