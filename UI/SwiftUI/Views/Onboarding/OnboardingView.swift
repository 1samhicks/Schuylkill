//
//  OnboardingView.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import SwiftUI

struct OnboardingView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> OnboardingEntryViewController {
        return onboardingEntryViewController
    }
    
    func updateUIViewController(_ uiViewController: OnboardingEntryViewController, context: Context) {
        
    }
    
    public typealias UIViewControllerType = OnboardingEntryViewController
    var onboardingEntryViewController : UIViewControllerType
    
    func performOnAppear() {
        
    }
    
    init() {
        self.onboardingEntryViewController = UIViewControllerType()
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension OnboardingView {
    class Coordinator: NSObject {
        var parent: OnboardingView

        init(_ parent: OnboardingView) {
            self.parent = parent
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
