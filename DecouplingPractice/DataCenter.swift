//
//  DataCenter.swift
//  DecouplingPractice
//
//  Created by Woody Liu on 2020/9/8.
//  Copyright © 2020 thisWhat. All rights reserved.
//

import Foundation
import UIKit



class DataCenter {
    
    var isRecevice: Bool = false {
        willSet {
            if newValue{ guard let void = self.trueVoid  else{ return }; void()  }
            else { guard let void = self.falseVoid else{ return }; void() }
        }
    }
    
    
   private var netWorker: NetWorker!
    
    
    var data: TaipeiJson? = nil
    var trueVoid: ( () -> () )?
    var falseVoid: ( () -> () )?
    
    init(netWorker: NetWorker) {
        self.netWorker = netWorker
        self.netWorker.dataReturnDelegate = self
    }
    
    
    
}


//MARK: NetWorker
extension DataCenter{
    
    func getData(){
        self.netWorker.askNetWork(httpMethod: .get, Components: nil, body: nil)
    }
    
}


extension DataCenter:  DataReturn {
 
   
     func dataReturn(data: [TaipeiJson]?) {
        guard let data = data else{ self.isRecevice = false ; return} ; self.isRecevice = true ; self.data = data[0]}

}
