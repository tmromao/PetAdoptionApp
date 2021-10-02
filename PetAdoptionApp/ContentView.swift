//
//  ContentView.swift
//  PetAdoptionApp
//
//  Created by Tiago Miguel de Jesus Romao on 02/10/2021.
//

import SwiftUI

struct Fact: Codable, Identifiable {
    let id = UUID()
    let fact : String
    
    private enum CodingKeys: CodingKey {
        case fact
    }
}

struct ContentView: View {
    
    @State private var facts : [Fact] = [Fact]()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                List(facts) { fact in
                    Text(fact.fact)
                }
            }.onAppear{
                
                Webservice().fetch(url: URL(string:
                                            "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs/all")!) { data in
                    return try! JSONDecoder().decode([Fact].self, from: data)
                    
                } completion: { result in
                    switch result {
                    case .success(let facts):
                        if let facts = facts {
                            DispatchQueue.main.async {
                                self.facts = facts
                            }
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                }
                                   }
                                    .navigationTitle("Dog facts")
                                   }
                                   
                                   //        Text("Hello, world!")
                                   //            .padding()
                                   //
                                   
                                   }
                                   }
                                   
                                   struct ContentView_Previews: PreviewProvider {
                    static var previews: some View {
                        ContentView()
                    }
                }
