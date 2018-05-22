//: [Previous](@previous)

import Foundation

//// 美国
//// (价格：美元/加仑)
//[
//    {
//        "fuel": "100LL",
//        "price": 5.60
//    },
//    {
//        "fuel": "Jet A",
//        "price": 4.10
//    }
//    ]...
//
//    // 加拿大
//    // (价格：加元/升)
//{
//    "fuels": [
//        {
//            "type": "100LL",
//            "price": 2.54
//        },
//        {
//            "type": "Jet A",
//            "price": 3.14,
//        },
//        {
//            "type": "Jet B",
//            "price": 3.03
//        }
//    ]
//}

//面对不同数据源建立模型的方法,1,通过拓展重载初始化方法分区 2.通过定义协议,子类遵循来区分

//MARK: - 首先定义基本所需类型和枚举
enum Fuel:String,Decodable{
    case jetA = "Jet A"
    case jetB = "Jet B"
    case oneHundredLowLead = "100LL"
}

struct AmericanFuelPrice:Decodable{
    let fuel:Fuel
    let price:Double  //美元/加仑
}

struct CanadianFuelPrice:Decodable{
    let type:Fuel
    let price:Double  // 加元/升
}

//MARK: - 2.通过定义协议,子类遵循来区分
protocol FuelPrice{
    var type:Fuel {get}
    var pricePerLiter:Double{get}
    var currency:String{get}
}

extension AmericanFuelPrice:FuelPrice{
    var type: Fuel {
        return self.fuel
    }
    
    var pricePerLiter: Double {
        return self.price / 3.78541
    }
    
    var currency: String {
        return "USD"
    }
}

extension CanadianFuelPrice:FuelPrice{
    var pricePerLiter: Double {
        return self.price
    }
    
    var currency: String {
        return "CAD"
    }
}


//MARK: - 1,通过拓展重载初始化方法分区
//struct FuelPrice:Decodable{
//    let type:Fuel
//    let pricePerLiter:Double
//    let currency:String
//}
//
//extension FuelPrice{
//    init(_ other:AmericanFuelPrice) {
//        self.type = other.fuel
//        self.pricePerLiter = other.price / 3.78541
//        self.currency = "USD"
//    }
//}
//
//extension FuelPrice{
//    init(_ other:CanadianFuelPrice) {
//        self.type = other.type
//        self.pricePerLiter = other.price
//        self.currency = "CAD"
//    }
//}


