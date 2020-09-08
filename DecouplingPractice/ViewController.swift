//
//  ViewController.swift
//  DecouplingPractice
//
//  Created by Woody Liu on 2020/9/8.
//  Copyright © 2020 thisWhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var containerView: UIView!
    
    var data: TaipeiJson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func loadData(){
        let network = NetWorker()
        let dataCenter = DataCenter(netWorker: network)
        dataCenter.trueVoid = {
            DispatchQueue.main.async {
                self.containerView.backgroundColor = .blue
                self.data = dataCenter.data
                self.label?.text = self.data.tunnelName
            }
        }
        
        dataCenter.getData()
        
    }
    
    
}

