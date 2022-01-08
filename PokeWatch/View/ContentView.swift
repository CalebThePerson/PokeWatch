//
//  ContentView.swift
//  PokeWatch
//
//  Created by Caleb Wheeler on 1/4/22.
//

import SwiftUI


struct ContentView: View {
    let pokemon = Pokemon()
    var body: some View {
        Text("Hello, world!")
            .onAppear(perform: {
                pokemon.getPokemon()
            })
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

