//
//  OnboardingEntryViewController.swift
//  Schuylkill-App
//
//  Created by Sam Hicks on 3/6/21.
//

import Foundation
import UIKit
import PaperOnboarding

public class OnboardingEntryViewController: UIViewController, PaperOnboardingDataSource {
    public func onboardingItemsCount() -> Int {
        return 3
    }

    public func onboardingItem(at index: Int) -> OnboardingItemInfo {

       return [
         OnboardingItemInfo(informationImage: Asset.key.image,
                                       title: "title",
                                 description: "description",
                                    pageIcon: Asset.key.image,
                                       color: UIColor.red,
                                  titleColor: UIColor.green,
                            descriptionColor: UIColor.gray,
                            titleFont: UIFont.italicSystemFont(ofSize: 14),
                             descriptionFont: UIFont.italicSystemFont(ofSize: 10) ),

         OnboardingItemInfo(informationImage: Asset.key.image,
                                        title: "title",
                                  description: "description",
                                     pageIcon: Asset.key.image,
                                        color: UIColor.red,
                                   titleColor: UIColor.green,
                             descriptionColor: UIColor.gray,
                                    titleFont: UIFont.italicSystemFont(ofSize: 14),
                              descriptionFont: UIFont.italicSystemFont(ofSize: 10)),

        OnboardingItemInfo(informationImage: Asset.key.image,
                                     title: "title",
                               description: "description",
                                  pageIcon: Asset.key.image,
                                     color: UIColor.red,
                                titleColor: UIColor.green,
                          descriptionColor: UIColor.gray,
                                 titleFont: UIFont.italicSystemFont(ofSize: 14),
                           descriptionFont: UIFont.italicSystemFont(ofSize: 10))
         ][index]
     }

    public override func viewDidLoad() {
      super.viewDidLoad()

      let onboarding = PaperOnboarding()
      onboarding.dataSource = self
      onboarding.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(onboarding)

      // add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
        let constraint = NSLayoutConstraint(item: onboarding,
                                            attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: attribute,
                                            multiplier: 1,
                                            constant: 0)
        view.addConstraint(constraint)
      }
    }

}
