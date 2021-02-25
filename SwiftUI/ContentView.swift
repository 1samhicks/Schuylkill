//
//  ContentView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        AuthenticationView()
    }
    
    func performOnAppear() {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
