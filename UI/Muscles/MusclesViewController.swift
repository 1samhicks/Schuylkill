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

public struct MuscleListView : UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = MusclesListViewController
    
    public func makeUIViewController(context: Context) -> MusclesListViewController {
        MusclesListViewController()
    }
    
    public func updateUIViewController(_ uiViewController: MusclesListViewController, context: Context) {
    }
    
}

public class MusclesListViewController : UIViewController {
    private lazy var collectionsView : MusclesCollectionView = MusclesCollectionView()
    @Injected var viewModel : MusclesListViewModel!
    
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        viewModel = makeViewModel()
        self.addChild(collectionsView)
        
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension MusclesListViewController : Resolving {
    func makeViewModel() -> MusclesListViewModel { return resolver.resolve() }
}
