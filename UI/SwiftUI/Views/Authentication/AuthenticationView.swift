//
//  ContentView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/5/21.
//

import Combine
import Resolver
import SwiftUI
import UIKit

struct AuthenticationView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = AuthenticationViewController
    var authenticationViewController: UIViewControllerType

    func performOnAppear() {
    }

    init() {
        self.authenticationViewController = UIViewControllerType()
    }

    public func makeUIViewController(context: Context) -> AuthenticationViewController {
        return authenticationViewController
    }

    public func updateUIViewController(_ uiViewController: AuthenticationViewController, context: Context) {
    }

    func makeCoordinator() -> AuthenticationView.Coordinator {
        return Coordinator(self)
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            AuthenticationView()
        }
    }
}

extension AuthenticationView {
    class Coordinator: NSObject {
        var parent: AuthenticationView

        init(_ parent: AuthenticationView) {
            self.parent = parent
        }
    }
}
