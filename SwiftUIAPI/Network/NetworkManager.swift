//
//  NetworkManager.swift
//  SwiftUIAPI
//
//  Created by Admin on 3/23/21.
//

import Foundation
class NetworkManager:ObservableObject {
    // step to work with HTTP request
    //1. create urlString
    //2. create session
    //3 working with your task
    
    let urlString = "https://peopleinfoapi.herokuapp.com/api/people"
    @Published var people = [People]()

    func performRequest()  {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            //let task =
            session.dataTask(with: url) {(data,respose,error) in
                if (error != nil)
                {
                    print(error!)
                }
                if let safeData = data {
                    //                    let dataString = String(data:safeData,encoding: .utf8)
                    self.parseJSON(peopleModel: safeData)
                    //                    print(dataString!)
                }
            }.resume() // start task
        }
    }
    
    func parseJSON(peopleModel: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData =  try decoder.decode(PeopleModel.self, from: peopleModel)
//            print(decodeData.data[0])
            
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
        session.dataTask(with: request){(data,res,err)in
          
            if err != nil {
                print(err!.localizedDescription)
                
            }
            if err == nil,let data = data, let response = res as? HTTPURLResponse {
                print(response.statusCode)
                print(data)
              
                DispatchQueue.main.async {
                    self.people.removeAll{
                        (person)-> Bool in
                        return person.id == id
                    }
                    self.performRequest()
                }
                
            }
            
        }.resume()
    }
    
    func createNew(person:People)  {
        
        var request = URLRequest(url:URL(string: urlString)!)
        request.httpMethod  = "POST"
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let parameters: [String: Any] = [
            "first_name": person.first_name,
            "last_name": person.last_name,
            "age": person.age,
            "active_date": person.active_date,
            
        ]
        // covert diectionary to json
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody =  jsonData
        
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data,_,err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            guard let response = data else {return}
            let status = String(data:response,encoding: .utf8) ?? ""
            
            print(status)
            
        }.resume()
        
    }
    func updatePerson(id:Int, person:People) {
        
        var request = URLRequest(url:URL(string: "\(urlString)/\(id)")!)
        print("url request to update \(request)")
        request.httpMethod  = "PUT"
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let parameters: [String: Any] = [
            "first_name": person.first_name,
            "last_name": person.last_name,
            "age": person.age,
            "active_date": person.active_date,
            
        ]
        // covert diectionary to json
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody =  jsonData
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request){(data,_,err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            guard let response = data else {return}
            let status = String(data:response,encoding: .utf8) ?? ""
            
            print(status)
            
        }.resume()
    }
}
