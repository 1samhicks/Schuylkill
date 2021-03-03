//
//  Model+Extensions.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/2/21.
//

import Foundation
import Amplify
import Amplify
import Resolver
import Combine

extension Model {
    
    public func save() {
        Amplify.DataStore.save(self) { result in
            switch(result) {
            case .success(let savedItem):
                print("Saved item: \(savedItem.id)")
            case .failure(let error):
                print("Could not save item to DataStore: \(error)")
            }
        }
    }
    /**
     open class GraphQLOperation<R: Decodable>: AmplifyOperation<
         GraphQLOperationRequest<R>,
         GraphQLResponse<R>,
         APIError
     Cannot convert return expression of type 'AnyPublisher<Result<[Self], GraphQLResponseError<[Self]>>, APIError>' to return type 'AnyPublisher<Any, APIError>
     > { }
     */
    
    public func queryAll(condition : Any) -> AnyPublisher<Result<[Self],GraphQLResponseError<[Self]>>, APIError> where Self : Decodable {
        //var list = .list(type(of:self))
        let tst = Amplify.API.query(request: .list(type(of:self)))
        return tst.resultPublisher
        
    }
    
    public func queryAll() -> AnyPublisher<Result<[Self],GraphQLResponseError<[Self]>>, APIError> where Self : Decodable {
        return
            Amplify.API.query(request: .list(type(of:self)))
                .resultPublisher
    }
    /**
            This is going to soft delete the record by setting its delete flag to true
    */
    mutating func delete() where Self : Deletable {
        self.deleted = true
        self.save()
    }
}
