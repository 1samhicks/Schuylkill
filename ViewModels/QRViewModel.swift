//
//  QRCodeReaderViewModel.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/22/21.
//

import Amplify
import Combine
import Foundation
import Resolver

class QRViewModel: ObservableObject, Identifiable, ViewModel {
    @LazyInjected var amplifyService: AmplifyAPIService?

    @Published var barcode: String?
    required init() {
        amplifyService = Resolver.resolve()
        let barcodePerson = $barcode.receive(on: DispatchQueue.main).sink { e in
            print(type(of: e))
        }
        print(barcodePerson)
    }
}
