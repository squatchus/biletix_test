//
//  GetFaresResponseParser.swift
//  biletix_swift
//
//  Created by Sergey Mazulev on 12.04.2020.
//  Copyright © 2020 squatch. All rights reserved.
//

import UIKit

enum ParserKeyPath: String {
    case Error = "Body.GetOptimalFaresOutput.error"
    case Currency = "Body.GetOptimalFaresOutput.currency"
    case Offers = "Body.GetOptimalFaresOutput.offers"
    case Directions = "directions.GetOptimalFaresDirection"
    case Flights = "flights.GetOptimalFaresFlight"
    case FlightInfo = "segments.AirSegment"
}

enum ParserKey: String {
    case ErrorCode = "code"
    case ErrorDescription = "description"
    case OfferFares = "GetOptimalFaresOffer"
    case Link = "link"
    case TotalPrice = "total_price"
    case FlightCarrier = "ak"
    case FlightNumber = "flight_number"
    case DepartureDate = "departure_date"
    case DepartureTime = "departure_time"
    case DepartureAirport = "departure_airport_code"
    case ArrivalDate = "arrival_date"
    case ArrivalTime = "arrival_time"
    case ArrivalAirport = "arrival_airport_code"
}

extension NSDictionary {
    func value(forKeyPath keyPath: ParserKeyPath) -> Any? {
        self.value(forKeyPath: keyPath.rawValue)
    }
    
    subscript(key: ParserKey) -> Value? {
        get {
            return self[key.rawValue]
        }
    }
}

class GetFaresResponseParser {

    let dict: NSDictionary
    
    init(dict: Dictionary<AnyHashable, Any>) {
        self.dict = dict as NSDictionary
    }
    
    func parse() -> (Result<[Fare], Error>) {
        if let error = errorFromResponse() {
            return .failure(error)
        }
        var fares = [Fare]()
        
        let currency = dict.value(forKeyPath: .Currency) as! String
        if let offers = dict.value(forKeyPath: .Offers) as? NSDictionary {
            let offerFares = offers[.OfferFares] as! [NSDictionary]
            for offer in offerFares {
                let totalPrice = offer[.TotalPrice] as! String
                let price = Decimal(string: totalPrice)!
                let offerLink = offer[.Link] as! String
                let directions = offer.value(forKeyPath: .Directions) as! [NSDictionary]
                let outboundFlightsNode = directions[0].value(forKeyPath: .Flights)!
                let returnFlightsNode = directions[1].value(forKeyPath: .Flights)!
                let outboundFlights = flightsFromSoapNode(outboundFlightsNode)
                let returnFlights = flightsFromSoapNode(returnFlightsNode)
                for outboundFlight in outboundFlights {
                    for returnFlight in returnFlights {
                        let fareLink = [offerLink, outboundFlight.linkSuffix, returnFlight.linkSuffix].joined()
                        let fare = Fare(price: price, currency: currency, link: fareLink, outboundFlight: outboundFlight, returnFlight: returnFlight)
                        fares.append(fare)
                    }
                }
            }
            return .success(fares)
        }
        return .failure(API.Error.unableToGetFares)
    }
    
    func errorFromResponse() -> Error? {
        if let errorDict = dict.value(forKeyPath: "Body.GetOptimalFaresOutput.error") as? Dictionary<String, String> {
            let code = errorDict["code"]!
            let description = errorDict["description"]
            if code == "SESSION_ERROR" {
                return API.Error.sessionError(description: description)
            } else if code != "OK" {
                return API.Error.error(code: code, description: description)
            }
        }
        return nil
    }
    
    func flightsFromSoapNode(_ node: Any) -> [Flight] {
        var flights = [Flight]()
        if let dict = node as? NSDictionary {
            let flight = flightFromDict(dict)
            flights.append(flight)
        } else if let array = node as? [NSDictionary] {
            for flightDict in array {
                let flight = flightFromDict(flightDict)
                flights.append(flight)
            }
        }
        return flights
    }
    
    func flightFromDict(_ dict: NSDictionary) -> Flight {
        let info = dict.value(forKeyPath: .FlightInfo) as! NSDictionary
        let link = dict[.Link] as! String;
        let carrier = info[.FlightCarrier] as! String
        let number = info[.FlightNumber] as! String
        let fullNumber = "\(carrier) \(number)"
        let depAirport = info[.DepartureAirport] as! String
        let arrAirport = info[.ArrivalAirport] as! String
        let depDate = info[.DepartureDate] as! String
        let depTime = info[.DepartureTime] as! String
        let arrDate = info[.ArrivalDate] as! String
        let arrTime = info[.ArrivalTime] as! String
        return Flight(flightNumber: fullNumber, departureDate: depDate, departureTime: depTime, departureAirport: depAirport, arrivalDate: arrDate, arrivalTime: arrTime, arrivalAirport: arrAirport, linkSuffix: link)
    }
    
}
