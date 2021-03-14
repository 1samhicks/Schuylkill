//
//  MuscleListView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/3/21.
//

import Combine
import SwiftUI
import UIKit

public struct MuscleListView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = MuscleCollectionViewController

    public func makeUIViewController(context: Context) -> MuscleCollectionViewController {
        MuscleCollectionViewController()
    }

    public func updateUIViewController(_ uiViewController: MuscleCollectionViewController, context: Context) {
    }
}

struct MuscleListView_Previews: PreviewProvider {
    static var previews: some View {
        MuscleListView()
    }
}
