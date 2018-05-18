//: Playground - noun: a place where people can play

import UIKit
import Foundation

struct Plane:Codable{
    var manufacturer:String
    var model:String
    var seats:Int
    
//    private enum CodingKeys:String,CodingKey{
//        case manufacturer
//        case model
//        case seats
//    }
//
//    init(from decoder:Decoder) throws{
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.manufacturer = try container.decode(String.self, forKey: .manufacturer)
//        self.model = try container.decode(String.self, forKey: .model)
//        self.seats = try container.decode(Int.self, forKey: .seats)
//    }
//
//    func encode(to encoder:Encoder) throws{
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.manufacturer, forKey: .manufacturer)
//        try container.encode(self.model, forKey: .model)
//        try container.encode(self.seats, forKey: .seats)
//    }
}

let planeJson =
"""
{
    "planes":[
        {
            "manufacturer":"Cessna",
            "model":"172 Skyhawk",
            "seats":4,
        },
        {
            "manufacturer":"Piper",
            "model":"PA-28 Cherokee",
            "seats":4,
        }
    ]
}
""".data(using: .utf8)!

let decoder = JSONDecoder()

if let keyedPlanes = try?decoder.decode([String:[Plane]].self, from: planeJson),
    let planes = keyedPlanes["planes"]{
    for i in planes{
        print(i.manufacturer)
        print(i.model)
        print(i.seats)
    }
    
    for i in 0..<planes.count{
        print(planes[i])
    }
}



//print([plane].manufacturer)
//print([plane].model)
//print([plane].seats)
//
//let encoder = JSONEncoder()
//encoder.outputFormatting = .prettyPrinted
//let json = try!encoder.encode(planes)
//print(String(data: json, encoding: .utf8)!)


