//
//  MusclesViewModel.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/24/21.
//

import Amplify
import Combine
import Foundation
import Resolver

class MusclesListViewModel: Identifiable, ViewModel {
    @LazyInjected var amplifyService: AmplifyAPIService?

    required init() {
        amplifyService = AmplifyAPIService()
    }

    public func queryAll() -> AnyCancellable? {
        return amplifyService?.getAllRecords(table: Muscle(friendlyName: ""))
    }
}
