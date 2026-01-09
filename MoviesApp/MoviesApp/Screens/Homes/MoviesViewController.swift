//
//  ViewController.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 29.12.25.
//

import UIKit
import SnapKit

class MoviesViewController: CustomViewController {
    
    private let viewModel: MoviesViewModel
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let headerLabel: UILabel = {
        let header = UILabel()
        header.text = "What do you want to watch?"
        header.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textColor = .white
        return header
    }()
    
    private let trendingMoviesLabel: UILabel = {
          let label = UILabel()
          label.text = "Trending"
          label.font = .systemFont(ofSize: 20, weight: .semibold)
          label.textColor = .white
          return label
      }()
    
    private lazy var categoriesView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           
           let spacing: CGFloat = 8.0
           let itemSize = CGSize(width: 100, height: 40)
           layout.minimumInteritemSpacing = spacing
           layout.minimumLineSpacing = spacing
           layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing * 2, bottom: spacing, right: spacing * 2)
           layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.tag = 1
        collectionView.backgroundColor = .background
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.register(CategoriesMovieViewCell.self, forCellWithReuseIdentifier: CategoriesMovieViewCell.reuseIdentifier)
           return collectionView
       }()
    
    private lazy var trendingMoviesList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let spacing: CGFloat = 30.0
        let itemSize = CGSize(width: 144, height: 210)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 11, bottom: 11, right: spacing)
        layout.itemSize = CGSize(width: 144, height: 210)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.tag = 0
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TrendingMoviesCell.self, forCellWithReuseIdentifier: TrendingMoviesCell.reuseIdentifier)
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    private lazy var selectedGenreMoviesList: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           
           let spacing: CGFloat = 16.0
           let horizontalInset: CGFloat = 22.0
           let numberOfColumns: CGFloat = 3
           let totalSpacing = (numberOfColumns - 1) * spacing + (horizontalInset * 2)
           let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / numberOfColumns
           let itemHeight: CGFloat = itemWidth * 1.5
           
           layout.minimumInteritemSpacing = spacing
           layout.minimumLineSpacing = spacing
           layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 20, right: horizontalInset)
           layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
           
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.tag = 2
           collectionView.showsVerticalScrollIndicator = false
           collectionView.showsHorizontalScrollIndicator = false
           collectionView.register(TrendingMoviesCell.self, forCellWithReuseIdentifier: TrendingMoviesCell.reuseIdentifier)
        collectionView.backgroundColor = .background
           return collectionView
       }()
    
    
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        loadInitialData()
    }
    
    private func loadInitialData() {
        viewModel.fetchTrendingMovies()
        viewModel.fetchMovies(.nowPlaying)
        categoriesView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [headerLabel, trendingMoviesLabel, trendingMoviesList, categoriesView, selectedGenreMoviesList].forEach(view.addSubview)
    }
    
    private func openDetails(movie: Movie) {
        let detailVC = DetailBuilder.build()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.onTrendingMoviesUpdated = { [weak self] in
            self?.trendingMoviesList.reloadData()
        }
        
        viewModel.onCategoryMoviesUpdated = { [weak self] in
            self?.selectedGenreMoviesList.reloadData()
        }
            
        viewModel.onError = { errorMessage in
            print("Error: \(errorMessage)")
        }
 }
    
    private func setupConstraints() {
         headerLabel.snp.makeConstraints { make in
             make.top.equalTo(view.safeAreaLayoutGuide)
             make.horizontalEdges.equalToSuperview().inset(22)
         }
         
         trendingMoviesLabel.snp.makeConstraints { make in
             make.top.equalTo(headerLabel.snp.bottom).offset(24)
             make.horizontalEdges.equalToSuperview().inset(22)
         }
         
         trendingMoviesList.snp.makeConstraints { make in
             make.top.equalTo(trendingMoviesLabel.snp.bottom).offset(24)
             make.horizontalEdges.equalToSuperview()
             make.height.equalTo(230)
         }
         
         categoriesView.snp.makeConstraints { make in
             make.top.equalTo(trendingMoviesList.snp.bottom).offset(24)
             make.horizontalEdges.equalToSuperview()
             make.height.equalTo(50)
         }
         
         selectedGenreMoviesList.snp.makeConstraints { make in
             make.top.equalTo(categoriesView.snp.bottom).offset(24)
             make.horizontalEdges.equalToSuperview()
             make.bottom.equalTo(view)
         }
     }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView.tag {

        case 0:
            let movie = viewModel.trendingMovies[indexPath.row]
            openDetails(movie: movie)

        case 2:
            let movie = viewModel.categoryMovies[indexPath.row]
            openDetails(movie: movie)

        case 1:
            let selectedCategory = viewModel.filterCategories[indexPath.row]
            viewModel.fetchMovies(selectedCategory)

        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0: =
            return viewModel.trendingMovies.count
        case 1:
            return viewModel.filterCategories.count
        case 2: 
            return viewModel.categoryMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView.tag == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingMoviesCell.reuseIdentifier, for: indexPath) as? TrendingMoviesCell
                guard let cell else {
                    return TrendingMoviesCell()
                }
                cell.config(with: viewModel.trendingMovies[indexPath.row])
                return cell
            } else if  collectionView.tag == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesMovieViewCell.reuseIdentifier, for: indexPath) as? CategoriesMovieViewCell
                guard let cell else {
                    return CategoriesMovieViewCell()
                }
                cell.config(with: viewModel.filterCategories[indexPath.row])
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingMoviesCell.reuseIdentifier, for: indexPath) as? TrendingMoviesCell
                guard let cell else {
                    return TrendingMoviesCell()
                }
                cell.config(with: viewModel.categoryMovies[indexPath.row])
                return cell
            }
        }
    }

