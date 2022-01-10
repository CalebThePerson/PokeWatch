//
//  ContentView.swift
//  PokeWatch
//
//  Created by Caleb Wheeler on 1/4/22.
//

import SwiftUI


struct ContentView: View {
    let pokemon = Pokemon()
    let data = DatabaseSave()
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    var body: some View {
        Text("Hello, world!")
            .onAppear(perform: {
//                pokemon.getPokemon()
//                signUpViewModel.signUp(email: "calebtheeperson@gmail.com", password: "1234567")
//                data.saveData()
            })
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

