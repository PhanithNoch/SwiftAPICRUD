//
//  CreateView.swift
//  SwiftUIAPI
//
//  Created by Admin on 3/24/21.
//

import SwiftUI

struct CreateView: View {
    @ObservedObject var networkManager = NetworkManager()

    @State var firstName:String = "" // binding
    @State var lastName:String = ""
    @State var age:String = ""
    @State var activeDate = "2021-03-11 14:19:20"
    var body: some View {
        VStack(alignment:.leading,spacing:20){
            TextField("FirstName",text:$firstName)
            TextField("LastName",text:$lastName)
            TextField("Age",text:$age)
            TextField("ActiveDate",text:$activeDate)
            
            Button(action: {
                let person: People = People(id: nil, first_name: self.firstName, last_name: lastName, age: age, active_date: activeDate, created_at: "", updated_at: "")
             
                networkManager.createNew(person: person)
               
            }, label: {
                Text("Save")
            })
            Spacer()
        }
        .navigationBarTitle("Create").padding(.all,30)
    }
    

   
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
