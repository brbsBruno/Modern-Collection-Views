//
//  MainView.swift
//  POCCompositionalLayout
//
//  Created by Bruno Barbosa on 29/09/22.
//

import UIKit

class MainView: UIView {

    // MARK: - Public properties

    var viewModel: MainViewModel? = MainViewModel()

    // MARK: - Private properties

    private var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem>! = nil
    private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, SectionItem>! = nil

    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: generateCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        return collectionView
    }()

    // MARK: - Initializers

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViewCode()
        configureDataSource()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewCode()
        configureDataSource()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
        configureDataSource()
    }

    // MARK: - Private methods

    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let section = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            switch section.type {
            case .videos: return self.generateHorizontalLayoutSection()
            case .articles: return self.generateVerticalLayoutSection()
            }
        }
    }

    private func generateHorizontalLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                     leading: 2,
                                                     bottom: 2,
                                                     trailing: 2)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(top: 20,
                                                        leading: 20,
                                                        bottom: 20,
                                                        trailing: 20)
        return section
    }

    private func generateVerticalLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                     leading: 2,
                                                     bottom: 2,
                                                     trailing: 2)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20,
                                                        leading: 20,
                                                        bottom: 20,
                                                        trailing: 20)
        return section
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SectionItem>(collectionView: collectionView) { collectionView, indexPath, _ in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier,
                                                                for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.label.text = "\(indexPath.section), \(indexPath.item)"
            return cell
        }

        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, SectionItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        snapshot.appendSections(viewModel!.items)
        viewModel?.items.forEach { section in
            if let articles = section.articles {
                snapshot.appendItems(articles.map(SectionItem.article), toSection: section)
            }

            if let videos = section.videos {
                snapshot.appendItems(videos.map(SectionItem.video), toSection: section)
            }
        }
        return snapshot
    }
}

extension MainView {

    // MARK: - View Code

    private func setupViewCode() {
        buildHierarchy()
        setupConstraints()
    }

    private func buildHierarchy() {
        addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

