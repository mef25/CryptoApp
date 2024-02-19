//
//  Webservice.swift
//  CryptoApp-MVVM-RxSwift
//
//  Created by Mehmet Emin Fırıncı on 16.02.2024.
//

import Foundation



enum CryptoError : Error{
    case serverError
    case parsingError
}

class Webservice{
    func downloadCurrencies(url : URL, completion : @escaping (Result<[Crypto], CryptoError>) -> () ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(.failure(.serverError))
            }else if let data = data{
                if let cryptolist = try? JSONDecoder().decode([Crypto].self, from: data){
                    completion(.success(cryptolist))
                }else{
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
    
    
    
}
