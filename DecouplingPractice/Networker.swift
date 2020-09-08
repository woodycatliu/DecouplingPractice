//
//  Networker.swift
//  DecouplingPractice
//
//  Created by Woody Liu on 2020/9/8.
//  Copyright © 2020 thisWhat. All rights reserved.
//

import Foundation

protocol DataReturn {
    func dataReturn(data: [TaipeiJson]? )
}

class NetWorker {
    
    let worker : JsonWorker = JsonWorker()
    let session = URLSession.shared
    
    var dataReturnDelegate: DataReturn?
    
    var url = URL(string: "https://tpnco.blob.core.windows.net/blobfs/Tunnels.json")
    
    
    public func askNetWork(httpMethod: HttpMethod, Components: [String : String]?, body: Data?){
        guard let url = self.url else { return}
        guard var urlString = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return}
        if let Components = Components , Components.count > 0{
            urlString.queryItems = Components.map({ URLQueryItem(name: String($0.key) , value: String($0.value)) })
        }
        
        guard let newUrl = urlString.url else {return }
        var request = URLRequest(url: newUrl, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 1200)
        request.httpMethod = httpMethod.rawValue
        
        if let body = body { request.httpBody = body}
        
        self.getData(request: request)
    }
    
    
    func getData(request: URLRequest) {
        session.loadData(url: request, with: {
            data,response,error in
            if let error = error { print(error); return }
            if  (response as? HTTPURLResponse)?.statusCode != 200 { print("error"); return }
            
            
            guard let data = data else{ return }
            
            let decodeData =  self.worker.decode(data: data, type: [TaipeiJson].self)
            self.dataReturnDelegate?.dataReturn(data: decodeData)
        })
    }
    
    
    
    
    
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        
    }
    
    
}

extension URLSession {
    
    func loadData(url: URLRequest, with completion: @escaping (Data?, URLResponse? , Error?) -> Void) {
        self.dataTask(with: url){
            data, response, error in
            completion(data,response,error)
        }.resume()
    }
}
