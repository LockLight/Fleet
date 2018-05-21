//: [Previous](@previous)

import Foundation

//自定义AnyDecodable,重写Decodable协议
public struct AnyDecodable:Decodable{
    public let value:Any
    public init(_ value:Any?){
        self.value = value ?? ()
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil(){
            self.value = ()
        }else if let bool = try? container.decode(Bool.self){
            self.value = bool
        }else if let int = try? container.decode(Int.self){
            self.value = int
        }else if let uint = try? container.decode(UInt.self){
            self.value = uint
        }else if let double = try? container.decode(Double.self){
            self.value = double
        }else if let string = try? container.decode(String.self){
            self.value = string
        }else if let array = try? container.decode([AnyDecodable].self){
            self.value = array.map{$0.value}
        }else if let dictionary = try? container.decode([String:AnyDecodable].self){
            self.value = dictionary.mapValues{$0.value}
        }else{
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "AnyCodable value cannot be decoded")
        }
    }
}

struct Report:Decodable{
    var title:String
    var body:String
    //metadata字典在当前结构体中无法定义为[String:Any]类型,值类型Any并不遵循Codable协议
    var metadata:[String:AnyDecodable]
}
