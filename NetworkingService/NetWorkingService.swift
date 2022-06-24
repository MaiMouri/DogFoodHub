//
//  NetWorkingService.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/06.
//

import Foundation

enum APIError: Error {
    case failedTogetData
}

class NetWorkingService {
    
    static let shared = NetWorkingService()
    
    func getDogfood(completion: @escaping (Result<[Dogfood], Error>) -> Void) {
        guard let url = URL(string: "https://cuddly-clear-september.glitch.me/getDogfoods") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(DogfoodResponse.self, from: data)
//                print(results)
                completion(.success(results.dogfoods))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        guard let url = URL(string: "https://cuddly-clear-september.glitch.me/getCategories") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(CategoryResponse.self, from: data)
//                print(results)
                completion(.success(results.categories))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getLifeStages(completion: @escaping (Result<[LifeStage], Error>) -> Void) {
        guard let url = URL(string: "https://cuddly-clear-september.glitch.me/getLifeStages") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(LifeStageResponse.self, from: data)
                print(results)
                completion(.success(results.lifeStages))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getFoodTypes(completion: @escaping (Result<[FoodType], Error>) -> Void) {
        guard let url = URL(string: "https://cuddly-clear-september.glitch.me/getFoodTypes") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(FoodTypeResponse.self, from: data)
                print(results)
                completion(.success(results.foodTypes))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getRanking(completion: @escaping (Result<[RankingData], Error>) -> Void) {
        guard let url = URL(string: "https://shopping.yahooapis.jp/ShoppingWebService/V2/categoryRanking?appid=\(Constants.yahoo_API_key)&period=weekly&category_id=4792") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(RankingApiResponse.self, from: data)
//                print(results)
                completion(.success(results.category_ranking.rankingData))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    
    
    func getDiscoverDogfoods(completion: @escaping (Result<[Dogfood], Error>) -> Void) {
            guard let url = URL(string: "") else {return }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(DogfoodResponse.self, from: data)
                    completion(.success(results.dogfoods))

                } catch {
                    completion(.failure(APIError.failedTogetData))
                }

            }
            task.resume()
        }
        
        
        func search(with query: String, completion: @escaping (Result<[Product], Error>) -> Void) {
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
            guard let url = URL(string: "\(Constants.baseYahooURL)?appid=\(Constants.yahoo_API_key)&genre_category_id=4792&query=\(query)") else { return }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else { return }
                do {
                    let results = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(results.hits))
                } catch {
                    completion(.failure(APIError.failedTogetData))
                }
            }
            task.resume()
        }
    
        func searchData(with query: String, completion: @escaping (Result<[Dogfood], Error>) -> Void) {
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
            guard let url = URL(string: "https://cuddly-clear-september.glitch.me/search?query=\(query)") else { return }
//            print(url)
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else { return }
                do {
                    let results = try JSONDecoder().decode(DogfoodResponse.self, from: data)
                    completion(.success(results.dogfoods))
                } catch {
                    completion(.failure(APIError.failedTogetData))
                }
            }
            task.resume()
        }
        
        
        func getProduct(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
            
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
            guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    
                    completion(.success(results.items[0]))
                } catch {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    
}
