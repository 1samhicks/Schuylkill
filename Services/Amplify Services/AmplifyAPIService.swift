//
//  AmplifyService.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/10/21.
//

import Amplify
import Combine
import CoreLocation
import Foundation

public class AmplifyAPIService: RuntimeService {
    var state: ServiceState?

    func publishError(error: Error) {
    }

    func publishValue(value: Event) {
    }

    func createMuscle() -> AnyCancellable {
        let muscle = Muscle(friendlyName: "Abs")
        let sink = Amplify.API.mutate(request: .create(muscle))
            .resultPublisher
            .sink { completion in
            if case let .failure(error) = completion {
                print("Failed to create graphql \(error)")
            }
        }
        receiveValue: { result in
            switch result {
            case .success(let muscle):
                print("Successfully created the todo: \(muscle)")
            case .failure(let graphQLError):
                print("Could not decode result: \(graphQLError)")
            }
            }
        return sink
    }

    func getAllRecords<T: Model>(table: T) -> AnyCancellable? {
        typealias APIError = Never
        return table.queryAll().sink {
            if case let .failure(error) = $0 {
                print("Got failed event with error \(error)")
            }
        } receiveValue: { result in
            switch result {
            case .success(let todo):
                print("Successfully retrieved todo: \(todo)")
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        }
    }

    public required init() {
    }

    var servicePublisher: some ServicePublisher {
        get {
            return AmplifyServiceModelPublisher()
        }
    }

    // @Published var user: User?

    func retrieveFitnessCenterData(at location: Location? = nil) {
    }

    func startWorkout(with workout: GymWorkout? = nil) {
    }

    func endWorkout(with workout: GymWorkout? = nil) {
    }

    func addExerciseMachine(_ machine: ExerciseMachine, withLocation location: Location, at: FitnessCenter) {
    }

    func addExerciseSet(withMachine machine: ExerciseMachine, andReps: [ExerciseRep], from: Temporal.DateTime, to: Temporal.DateTime) {
    }
    func createSubscription<T: Model>(rawValue: String) -> GraphQLSubscriptionOperation<T> {
        let subscription = Amplify.API.subscribe(request: .subscription(of: T.self, type: GraphQLSubscriptionType(rawValue: rawValue)!))
        return subscription
    }
}
