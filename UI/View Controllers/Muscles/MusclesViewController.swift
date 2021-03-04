//
//  MusclesViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 2/23/21.
//

import Foundation
import UIKit
import SwiftUI
import Resolver
import Combine

public class MuscleCollectionViewController : UIViewController {
    @State var muscleSubscription: AnyCancellable?
    private lazy var collectionsView : MusclesCollectionView = MusclesCollectionView()
    lazy var viewModel : MusclesListViewModel = makeViewModel()
    
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        self.addChild(collectionsView)
        //muscleSubscription = viewModel
        
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension MuscleCollectionViewController : Resolving {
    func makeViewModel() -> MusclesListViewModel { return MusclesListViewModel() }
}
