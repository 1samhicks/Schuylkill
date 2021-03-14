//
//  MusclesViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/23/21.
//

import Combine
import Foundation
import Resolver
import SwiftUI
import UIKit

public class MuscleCollectionViewController: UIViewController {
    @State var muscleSubscription: AnyCancellable?
    private lazy var collectionsView = MusclesCollectionView()
    lazy var viewModel: MusclesListViewModel = makeViewModel()

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override public func viewDidLoad() {
        self.addChild(collectionsView)
        muscleSubscription = viewModel.queryAll()
    }
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension MuscleCollectionViewController: Resolving {
    func makeViewModel() -> MusclesListViewModel { return MusclesListViewModel() }
}
