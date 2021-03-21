import UIKit

final class MusclesCollectionView: UICollectionViewController {
  // MARK: - Properties
  private let reuseIdentifier = "FlickrCell"
  private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
  private var searches: [FlickrSearchResults] = []
  private let flickr = Flickr()
  private let itemsPerRow: CGFloat = 3
}

// MARK: - Private
private extension MusclesCollectionView {
  func photo(for indexPath: IndexPath) -> FlickrPhoto {
    return searches[indexPath.section].searchResults[indexPath.row]
  }
}

// MARK: - Text Field Delegate
extension MusclesCollectionView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard
      let text = textField.text,
      !text.isEmpty
    else { return true }

    // 1
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    textField.addSubview(activityIndicator)
    activityIndicator.frame = textField.bounds
    activityIndicator.startAnimating()

    flickr.searchFlickr(for: text) { searchResults in
      DispatchQueue.main.async {
        activityIndicator.removeFromSuperview()

        switch searchResults {
        case .failure(let error) :
          // 2
          print("Error Searching: \(error)")
        case .success(let results):
          // 3
          print("""
            Found \(results.searchResults.count) \
            matching \(results.searchTerm)
            """)
          self.searches.insert(results, at: 0)
          // 4
          self.collectionView?.reloadData()
        }
      }
    }

    textField.text = nil
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - UICollectionViewDataSource
extension MusclesCollectionView {
  // 1
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return searches.count
  }

  // 2
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return searches[section].searchResults.count
  }

  // 3
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath)
                                                                    -> UICollectionViewCell {
    // 1
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: reuseIdentifier,
      for: indexPath
    ) as! MuscleCell
    // swiftlint:disable:previous force_cast

    // 2
    let flickrPhoto = photo(for: indexPath)
    cell.backgroundColor = .white
    // 3
    cell.imageView.image = flickrPhoto.thumbnail

    return cell
  }
}

// MARK: - Collection View Flow Layout Delegate
extension MusclesCollectionView: UICollectionViewDelegateFlowLayout {
  // 1
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    // 2
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  // 3
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInsets
  }

  // 4
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return sectionInsets.left
  }
}
