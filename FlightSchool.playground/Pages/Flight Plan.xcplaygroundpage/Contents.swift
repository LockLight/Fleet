//: [Previous](@previous)

import Foundation

struct FlightPlan:Decodable{
    var aircraft:Aircraft
    var route:[String]
    var flightRules:FlightRules
    var remarks:String?
    
    private var departureDates:[String:Date]
    var proposedDepartureDates:Date?{
        return departureDates["proposed"]
    }
    var actualDepartureDates:Date?{
        return departureDates["actual"]
    }
    
    
    
    private enum Codingkeys:String,CodingKey{
        case aircraft
        case route
        case flightRules = "flight_rules"
        case remarks
        case departureDates = "departure_time"
    }//自定义key的名称
}

struct Aircraft:Decodable{
    var identification:String
    var color:String
}

enum FlightRules:String,Decodable{
    case visual = "VFR"     //目视飞行规则
    case instrument = "IFR"  //仪表飞行规则
}

let json = """
{
    "aircraft": {
        "identification": "NA12345",
        "color": "Blue/White"
    },
    "flight_rules": "IFR",
    "route": ["KTTD", "KHIO"],
    "departure_time": {
        "proposed": "2018-04-20T14:15:00-0700",
        "actual": "2018-04-20T14:20:00-0700"
    },
    "remarks": null
}
""".data(using: .utf8)!

var decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601

//使用可选绑定避免意外
if let plan = try? decoder.decode(FlightPlan.self, from: json){
    print(plan.aircraft.identification)
    print(plan.actualDepartureDates!)
    print(plan.proposedDepartureDates ?? "")
}





