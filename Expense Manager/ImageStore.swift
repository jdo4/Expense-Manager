//
//  ImageStore.swift
//  Assignment_4
//
//  Created by JD on 2022-12-08.
//

import Foundation
import UIKit
enum PhotosResult{
    case success([BModel])
    case failure (Error)
}

enum ImageResult{
    case success(UIImage)
    case failure(Error)
}

enum PhotoError : Error{
    case photoCreationError
}

enum JSONError : Error{
    case invalidJSONData
}
class ImageStore{
    var result : PhotosResult!
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func getAllPhotos(completion: @escaping(PhotosResult)->Void){
        print("URL RUN COMPLETELY")
        let components = URLComponents(string: "https://api.npoint.io/196de63dbc6a37560778/")
        let url = components?.url
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request){
            (data, responce, error)->Void in
            if let jsonData = data{
                self.result = self.ImageCall(fromJSON: jsonData)
            }else if let reqErr = error {
                print("Error fetching intesting photos: \(reqErr)")
            }else{
                print("Unexpected error with the request")
            }
            OperationQueue.main.addOperation {
                completion(self.result)
            }
        }
        task.resume()
    }
    
    func ImageCall(fromJSON data: Data)->PhotosResult{
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let photosArray = jsonDictionary["data"] as? [[String:Any]]
                   
            else{
                return .failure(JSONError.invalidJSONData)
            }
            var finalPhotos = [BModel]()
            for photoJSON in photosArray{
                if let photo = photo(fromJSON: photoJSON){
                    finalPhotos.append(photo)
                }
            }
            if finalPhotos.isEmpty && !photosArray.isEmpty{
                return .failure(JSONError.invalidJSONData)
            }
            return .success(finalPhotos)
        }catch let error{
            return .failure(error)
        }
    }
    func photo(fromJSON json: [String:Any])-> BModel?{
        guard
             let id = json["id"] as! String?,
             let name = json["name"] as! String?,
             let country = json["country"] as! String?,
             let remoteURL = json["image"] as! String?
        else{
            return nil
        }
        return BModel(id: id, name: name, country: country, imgURL: remoteURL)
    }
    func fetchImage(for photo: BModel, completion: @escaping(ImageResult)->Void){
        let photoURL = photo.imgURL
        let request = URLRequest(url: URL(string: photoURL)!)
        let task = session.dataTask(with: request){
            (data, response, error)->Void in
            let result = self.processImageResult(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageResult(data: Data?, error: Error?)->ImageResult{
        guard
            let imgData = data,
            let img = UIImage(data: imgData)
        else{
            if(data == nil){
                return .failure(error!)
            }else{
                return .failure(PhotoError.photoCreationError)
            }
        }
        return .success(img)
    }
}
