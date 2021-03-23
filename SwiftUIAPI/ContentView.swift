//
//  ContentView.swift
//  SwiftUIAPI
//
//  Created by Admin on 3/23/21.
//

import SwiftUI

struct ContentView: View {
    //1.
      @ObservedObject var networkManager = NetworkManager()

       
       var body: some View {
     
           NavigationView {
          
               //3.
            List {
                NavigationLink(destination:CreateView()){
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Create New")
                    })
                }
             
                ForEach(networkManager.people, id:\.id){ person in
                  
                        VStack{
                            Text(person.first_name).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text(person.last_name).font(.caption)
                        }
                    
                }.onDelete(perform: { indexSet in
                    indexSet.forEach{
                        (index) in
                        networkManager.deletePeople(id: index)
                    }
                })
            }
            
            .navigationTitle("List People")
         
               //2.
             
           }
           .onAppear() {
            self.networkManager.performRequest()

           }
        
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
