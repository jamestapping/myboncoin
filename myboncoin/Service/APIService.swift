//
//  APIService.swift
//  myboncoin
//
//  Created by james on 03/04/2023.
//

import Foundation

struct APIService {
    func fetch<T: Decodable>(url: URL?, type: T.Type, completion: @escaping(Result<[T], APIError> ) -> Void ) {
        guard  let url =  url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let dataResponse = try decoder.decode([T].self, from: data)
                    completion(Result.success(dataResponse))
                } catch  {
                    print (error)
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
