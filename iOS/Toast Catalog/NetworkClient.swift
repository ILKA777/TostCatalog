import Foundation

protocol Networking {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class NetworkClient {
    let networking: Networking
    
    init(networking: Networking = URLSession.shared) {
        self.networking = networking
    }
    
    func getItems(completion: @escaping (Result<[Item], Error>) -> Void) {
        let urlString = "https://my-json-server.typicode.com/sumup-challenges/mobile-coding-challenge-data/items/"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        networking.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let items = try decoder.decode([Item].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

extension URLSession: Networking {
}
