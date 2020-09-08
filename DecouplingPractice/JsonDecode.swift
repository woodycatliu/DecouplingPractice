//
//  JsonDecode.swift
//  DecouplingPractice
//
//  Created by Woody Liu on 2020/9/8.
//  Copyright © 2020 thisWhat. All rights reserved.
//

import Foundation



class JsonWorker {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func decode<T: Codable>(data:Data , type: T.Type) -> T?{
        
        do{ let result = try decoder.decode( type, from: data) ;return result }
        catch { print("\(error)") ;return nil }
    }
    
    func encode<T: Codable>(data: T) -> Data? { return nil }
    
    
}


struct TaipeiJson: Codable{
    var tunnelName: String
    
    enum CodingKeys: String, CodingKey {
        case tunnelName = "tunnel_name"
    }
}
