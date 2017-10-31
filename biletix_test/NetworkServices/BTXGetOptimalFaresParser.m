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

static NSString* const kCurrencyKeyPath = @"Body.GetOptimalFaresOutput.currency";
static NSString* const kOffersKeyPath = @"Body.GetOptimalFaresOutput.offers.GetOptimalFaresOffer";
static NSString* const kDirectionsKeyPath = @"directions.GetOptimalFaresDirection";
static NSString* const kFlightsKeyPath = @"flights.GetOptimalFaresFlight";
static NSString* const kFlightInfoKeyPath = @"segments.AirSegment";

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

@implementation BTXGetOptimalFaresParser

+ (NSArray <BTXFare *>*)faresFromResponseDict:(NSDictionary *)dict {
    @try {
        NSMutableArray *fares = [NSMutableArray new];
        
        NSString *currency = [dict valueForKeyPath:kCurrencyKeyPath];
        NSArray *offers = [dict valueForKeyPath:kOffersKeyPath];
        for (NSDictionary *offer in offers) {
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
        return [fares copy];
    }
    @catch (NSException *exception) {
        NSLog(@"Error (can't parse response): %@", exception);
        return nil;
    }
    return nil;
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

@end
