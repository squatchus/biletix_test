# CleanSwift demo

Sample app with CleanSwift architecture.

Originally this was a sample app for a job interview on iOS developer position in Biletix company (2017). 
It was written in Objective-C and reimplemented in Swift 5.2 with CleanSwift architecture (inspired by [YARCH](https://github.com/alfa-laboratory/YARCH) implementation of the original architecture).
Old Objective-C version now moved into a [seperate branch](https://github.com/squatchus/demo-project/tree/objc).

The app communicates with SOAP API and therefore network client is based on the trial version of [SOAPEngine](https://github.com/priore/SOAPEngine) - the most supported library for SOAP API.
Trial version is limited and only works on the simulator. 

Implemented network client creates a new instance of SOAPEngine for every request, which is advised practice from developers of the original library.

The functionality of this demo is quite simple - it searches flight fares for selected dates and destinations.
For destinations it operates IATA codes, which by default is set to MOW (for Moscow) and LED (for Saint-Petersburg).
