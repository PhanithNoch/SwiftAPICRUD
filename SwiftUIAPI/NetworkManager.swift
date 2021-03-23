//
//  NetworkManager.swift
//  SwiftUIAPI
//
//  Created by Admin on 3/23/21.
//

import Foundation
class NetworkManager:ObservableObject {
 
let urlString = "https://peopleinfoapi.herokuapp.com/api/people"
    @Published var people = [People]() // make it published
    func performRequest()  {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data,respose,error) in
                if (error != nil)
                {
                    print(error!)
                }
                if let safeData = data {
//                    let dataString = String(data:safeData,encoding: .utf8)
                    self.parseJSON(peopleModel: safeData)
//                    print(dataString!)
                }
            }.resume()
        }
    }
    
    func parseJSON(peopleModel: Data) {
        let decoder = JSONDecoder()
        do {
           let decodeData =  try decoder.decode(PeopleModel.self, from: peopleModel)
            print(decodeData.data[0])
            DispatchQueue.main.async {
                self.people = decodeData.data
            }

        }
        catch{
            print("error parse JSON \(error)")
        }
    }
    
    
    func deletePeople(id: Int)  {
        let personId =  people[id].id
        print(personId!)

        var request = URLRequest(url:URL(string: "\(urlString)/\(personId!)")!)

        request.httpMethod  = "DELETE"
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data,_,err)in

            if err != nil {
                print(err!.localizedDescription)

            }
            guard let response = data else {return}
            let status = String(data:response,encoding: .utf8) ?? ""
            DispatchQueue.main.async {
                self.people.removeAll{
                    (person)-> Bool in
                    return person.id == id
                }
                self.performRequest()
            }

        }.resume()
    }
}
