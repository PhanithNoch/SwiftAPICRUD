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
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            //3
            List {
                ForEach(networkManager.people, id:\.id){ person in
                    
                    NavigationLink(destination:UpdateView(firstName: person.first_name, lastName: person.last_name, age: person.age, activeDate: person.active_date,id:person.id!)){
                        VStack{
                            Text(person.first_name).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text(person.last_name).font(.caption)
                            
                        }
                    }.alert(isPresented: $showAlert, content: { self.alert })
                    //4
                }
                
                .onDelete(perform: {
                    
                    indexSet in
                    
                    indexSet.forEach{
                        (index) in
                        networkManager.deletePeople(id: index)
                    }
                }
                )
            }.listStyle(InsetGroupedListStyle())
            .navigationTitle("List People")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    NavigationLink(destination:CreateView()){
                        Button(action: {}, label: {
                            Text("Create")
                        })
                    }
                }
            }
            //5
            .onAppear() {
                self.networkManager.performRequest()
                
            }
        }
        
    }
    var alert: Alert {
           Alert(title: Text("Message"), message: Text("Record Deleted"), dismissButton: .default(Text("Close")))
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
