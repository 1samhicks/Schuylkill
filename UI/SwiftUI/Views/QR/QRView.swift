//
//  QRView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/3/21.
//

import SwiftUI

public struct QRView: UIViewControllerRepresentable {
    public typealias UIViewControllerType = QRViewController

    public func makeUIViewController(context: Context) -> QRViewController {
        return QRViewController()
    }

    public func updateUIViewController(_ uiViewController: QRViewController, context: Context) {
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        QRView()
    }
}
