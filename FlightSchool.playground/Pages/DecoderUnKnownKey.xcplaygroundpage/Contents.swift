//: [Previous](@previous)

import Foundation

//{
//    "points": ["KSQL", "KWVI"],
//    "KSQL": {
//        "code": "KSQL",
//        "name": "San Carlos Airport"
//    },
//    "KWVI": {
//        "code": "KWVI",
//        "name": "Watsonville Municipal Airport"
//    }
//}    points建---->动态

public struct Route: Decodable {
    public struct Airport: Decodable {
        public var code: String
        public var name: String
    }
    
    public var points: [Airport]
    
    //自定义CodingKeys解析未知的键
    private struct CodingKeys: CodingKey {
        var stringValue: String
        
        var intValue: Int? {
            return nil
        }
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
        
        static let points =
            CodingKeys(stringValue: "points")!
    }
    
    
    //重写Decodable协议来解析,动态构建机场列表
    public init(from coder: Decoder) throws {
        let container = try coder.container(keyedBy: CodingKeys.self)

        var points: [Airport] = []
        let codes = try container.decode([String].self, forKey: .points)
        for code in codes {
            let key = CodingKeys(stringValue: code)!
            let airport = try container.decode(Airport.self, forKey: key)
            points.append(airport)
        }
        self.points = points
    }
}
