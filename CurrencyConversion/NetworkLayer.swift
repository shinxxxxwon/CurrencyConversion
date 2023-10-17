//
//  NetworkLayer.swift
//  CurrencyConversion
//
//  Created by 신정원 on 2023/10/17.
//

import Foundation

enum NetworkError : Error {
    case badUrl
}

struct NetworkLayer {
    
    static func fetchJson(completion: @escaping (CurrencyModel) -> Void ) {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else {
            return
        }
        
        //data Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            do{
                let currentModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
                
                completion(currentModel)
                
            }catch{
                print(error)
            }
            
        }.resume()
        
    }
    
    //async + await
    static func fetchJsonAsyncAwait() async throws-> CurrencyModel {
        
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }
        
        //data Task
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            
            let httpUrlResponse = response as? HTTPURLResponse
            
            if(httpUrlResponse?.statusCode == 200){
                throw NetworkError.badUrl
            }
            
            let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
            
            return currencyModel
            
        }catch{
            throw error
        }
    }
}
