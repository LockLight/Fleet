//: [Previous](@previous)

import Foundation

class EconmSeat:Decodable{
    var number:Int
    var letter:String
}

class PremiumEconmSeat:EconmSeat{
    var mealPreference:String?
    
    //子类PremiumEconmSeat继承自父类EconmSeat
    //需要再子类中实现CodingKeys和init(from:)即decoder的初始化方法
    //否则该类的对象无法正常解析,都为nil
    
    private enum CodingKeys:String,CodingKey{
        case mealPreference
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealPreference = try container.decode(String.self, forKey: .mealPreference)
        try super.init(from: decoder)
    }
}
