//
//  CreateView.swift
//  SwiftUIAPI
//
//  Created by Admin on 3/24/21.
//

import SwiftUI

struct CreateView: View {
    
    @State var firstName:String = ""
    @State var lastName:String = ""
    @State var age:String = ""
    @State var activeDate = "2021-03-11 14:19:20"
    var body: some View {
        VStack(alignment:.center,spacing:20){
            TextField("FirstName",text:$firstName)
            TextField("LastName",text:$lastName)
            TextField("Age",text:$age)
            TextField("ActiveDate",text:$activeDate)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Save")
            })
        }.padding()
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
