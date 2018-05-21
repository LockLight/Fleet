//: [Previous](@previous)

import Foundation
let json = """
[
    {
        "type": "bird",
        "genus": "Chaetura",
        "species": "Vauxi"
    },
    {
        "type": "plane",
        "identifier": "NA12345"
    }
]
""".data(using: .utf8)!

struct bird:Decodable{
    var genus:String
    var species:String
}

struct plane:Decodable{
    var identifier:String
}

//泛型枚举
enum Either<T,U>{
    case left(T)
    case right(U)
}

//拓展Either类型,自定义Decodabel协议
extension Either:Decodable where T:Decodable,
                                 U:Decodable{
    init(from decoder: Decoder) throws {
        if let value = try? T(from: decoder){
            self = .left(value)
        }else if let value = try? U(from: decoder){
            self = .right(value)
        }else{
            let context = DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Cannot decode\(T.self) or \(U.self)")
            throw DecodingError.dataCorrupted(context)
        }
    }
}

let decoder = JSONDecoder()
let objects = try! decoder.decode([Either<bird,plane>].self, from: json)

for object in objects {
    switch object {
    case .left(let brid):
        print("\(brid.genus)----\(brid.species)")
    case .right(let plane):
        print("\(plane.identifier)")
    }
}



