//
//  DetailsPageController.swift
//  CountriesApp
//
//  Created by Default on 28.04.24.
//

import UIKit

class DetailsPageController: UIViewController{
    
  
    let name: String?
    let aboutflags: String?
    let flagUrl: URL?
    let nativeName: String?
    let spellingCountry: [String]?
    let capitalOfCountry: [String]?
    let regionOfCountry: String?
    let neighbors: [String]?
    
    init(name: String?,
         aboutflags: String?,
         flagUrl: URL?,
         nativeName: String?,
         spellingCountry: [String]?,
         capitalOfCountry: [String]?,
         regionOfCountry: String?,
         neighbors: [String]?) {
        self.name = name
        self.aboutflags = aboutflags
        self.flagUrl = flagUrl
        self.nativeName = nativeName
        self.spellingCountry = spellingCountry
        self.capitalOfCountry = capitalOfCountry
        self.regionOfCountry = regionOfCountry
        self.neighbors = neighbors
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var mainView: UIView = {
        let mv = UIView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()
    
    var countryName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lb.textColor = UIColor.black
        return lb
    }()
        
    var shadowView: UIView = {
        let shv = UIView()
        shv.translatesAutoresizingMaskIntoConstraints = false
        shv.backgroundColor = .clear
        shv.layer.shadowColor = UIColor.black.cgColor
        shv.layer.shadowOffset = .zero
        shv.layer.shadowRadius = 2
        shv.layer.shadowOpacity = 0.5
        shv.layer.shadowOffset = CGSize(width: -1, height: 1)
        return shv
    }()
        
    var flagImage: UIImageView = {
        let im = UIImageView()
        im.translatesAutoresizingMaskIntoConstraints = false
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        im.layer.shadowColor = UIColor.black.cgColor
        im.layer.cornerRadius = 20
        return im
    }()
        
    var flagInfo: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.textColor = UIColor.black
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    var aboutFlag: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.textColor = UIColor.black
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
        
    var stackViewForAllInfo: UIStackView = {
        var st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.spacing = 20
        st.axis = .vertical
        return st
    }()
    
    var starckViewName: UIStackView = {
        var st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.spacing = 50
        return st
    }()
    
    var labelN: UILabel = {
        var lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var natName: UILabel = {
        var nt = UILabel()
        nt.translatesAutoresizingMaskIntoConstraints = false
        return nt
    }()
    
    var starckViewSpelling: UIStackView = {
        var st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.spacing = 50
        return st
    }()
    
    var labelSpelling: UILabel = {
        var lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var SpellingName: UILabel = {
        var nt = UILabel()
        nt.translatesAutoresizingMaskIntoConstraints = false
        return nt
    }()
    
    var starckViewCapital: UIStackView = {
        var st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.spacing = 50
        return st
    }()
    
    var labelCapital: UILabel = {
        var lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var capitalName: UILabel = {
        var nt = UILabel()
        nt.translatesAutoresizingMaskIntoConstraints = false
        return nt
    }()
    
    var starckViewRegion: UIStackView = {
        var st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.spacing = 50
        return st
    }()
    
    var labelRegion: UILabel = {
        var lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var RegionName: UILabel = {
        var nt = UILabel()
        nt.translatesAutoresizingMaskIntoConstraints = false
        return nt
    }()
    var starckViewNeighbors: UIStackView = {
        var st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        st.spacing = 50
        return st
    }()
    
    var labelNeighbors: UILabel = {
        var lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var neighborsName: UILabel = {
        var nt = UILabel()
        nt.translatesAutoresizingMaskIntoConstraints = false
        return nt
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
    }
    
    func addViews() {
        view.addSubview(mainView)
        mainView.backgroundColor = UIColor.white
        mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        mainView.addSubview(countryName)
        setUpCountryName()
        mainView.addSubview(shadowView)
        setUpFlag()
        flagImage.image = try? UIImage(data: Data(contentsOf: flagUrl ?? URL(string: "https://flagcdn.com/w320/md.png")!))
        shadowView.addSubview(flagImage)
        mainView.addSubview(flagInfo)
        setUpflagInfo()
        mainView.addSubview(aboutFlag)
        setUpaboutFlag()
        mainView.addSubview(stackViewForAllInfo)
        setUpstackViewForAllInfo()
        
        stackViewForAllInfo.addArrangedSubview(starckViewName)
        starckViewName.addArrangedSubview(labelN)
        starckViewName.addArrangedSubview(natName)
        setUpstarckViewName()
        
        stackViewForAllInfo.addArrangedSubview(starckViewSpelling)
        starckViewSpelling.addArrangedSubview(labelSpelling)
        starckViewSpelling.addArrangedSubview(SpellingName)
        setUpsstarckViewSpelling()
    
        stackViewForAllInfo.addArrangedSubview(starckViewCapital)
        starckViewCapital.addArrangedSubview(labelCapital)
        starckViewCapital.addArrangedSubview(capitalName)
        setUpstarckViewCapital()
        
        stackViewForAllInfo.addArrangedSubview(starckViewRegion)
        starckViewRegion.addArrangedSubview(labelRegion)
        starckViewRegion.addArrangedSubview(RegionName)
        setUpstarckViewRegion()
        
        stackViewForAllInfo.addArrangedSubview(starckViewNeighbors)
        starckViewNeighbors.addArrangedSubview(labelNeighbors)
        starckViewNeighbors.addArrangedSubview(neighborsName)
        setUpstarckViewNeighbors()
    }
    
    //MARK: setupFunctions
    
    func setUpstackViewForAllInfo() {
        stackViewForAllInfo.widthAnchor.constraint(equalToConstant: 350).isActive = true
        stackViewForAllInfo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackViewForAllInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 460).isActive = true
        stackViewForAllInfo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    func setUpCountryName() {
        countryName.widthAnchor.constraint(equalToConstant: 300).isActive = true
        countryName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countryName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        countryName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        countryName.textColor = UIColor.black
        countryName.font = UIFont(name: "SFPro-Regular", size: 17)
        countryName.textAlignment = .center
        if name == nil {
            countryName.text = "Undefined"
        }
        else{
            countryName.text = name
        }
        countryName.numberOfLines = 0
        countryName.lineBreakMode = .byWordWrapping
    }
    
    func setUpflagInfo() {
        flagInfo.widthAnchor.constraint(equalToConstant: 120).isActive = true
        flagInfo.heightAnchor.constraint(equalToConstant: 19).isActive = true
        flagInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 290).isActive = true
        flagInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        flagInfo.text = "About the flag"
        flagInfo.textColor = UIColor.black
        flagInfo.font = UIFont(name: "SFPro-Regular", size: 16)
        flagInfo.textAlignment = .center
        flagInfo.numberOfLines = 0
        flagInfo.lineBreakMode = .byWordWrapping
    }
    
    func setUpaboutFlag() {
        aboutFlag.widthAnchor.constraint(equalToConstant: 325).isActive = true
        aboutFlag.heightAnchor.constraint(equalToConstant: 85).isActive = true
        aboutFlag.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 310).isActive = true
        aboutFlag.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        aboutFlag.textColor = UIColor.black
        aboutFlag.text = aboutflags
        aboutFlag.font = UIFont(name: "SFPro-Regular", size: 14)
        aboutFlag.textAlignment = .center
        aboutFlag.numberOfLines = 0
        aboutFlag.lineBreakMode = .byWordWrapping
    }
    
    func setUpFlag() {
        shadowView.widthAnchor.constraint(equalToConstant: 343).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 228).isActive = true
        shadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shadowView.layer.cornerRadius = 30
    }
    
    func setUpstarckViewName() {
        starckViewName.widthAnchor.constraint(equalToConstant: 327).isActive = true
        starckViewName.heightAnchor.constraint(equalToConstant: 17).isActive = true
        starckViewName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        
        labelN.widthAnchor.constraint(equalToConstant: 57).isActive = true
        labelN.heightAnchor.constraint(equalToConstant: 17).isActive = true
        labelN.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelN.text = "Native name:"
        labelN.textColor = UIColor.black
        labelN.font = UIFont(name: "SFPro-Regular", size: 14)
        labelN.numberOfLines = 0
        labelN.lineBreakMode = .byWordWrapping
        
        natName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        natName.heightAnchor.constraint(equalToConstant: 17).isActive = true
        natName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 230).isActive = true
        natName.textColor = UIColor.black
        if nativeName == nil {
            natName.text = "Undefined"
        }
        else{
            natName.text = nativeName
        }
        natName.font = UIFont(name: "SFPro-Regular", size: 14)
        natName.numberOfLines = 0
        natName.lineBreakMode = .byWordWrapping
    }
    
    func setUpsstarckViewSpelling() {
        starckViewSpelling.widthAnchor.constraint(equalToConstant: 327).isActive = true
        starckViewSpelling.heightAnchor.constraint(equalToConstant: 17).isActive = true
        starckViewSpelling.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        
        labelSpelling.widthAnchor.constraint(equalToConstant: 57).isActive = true
        labelSpelling.heightAnchor.constraint(equalToConstant: 17).isActive = true
        labelSpelling.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelSpelling.text = "Spelling:"
        labelSpelling.textColor = UIColor.black
        labelSpelling.font = UIFont(name: "SFPro-Regular", size: 14)
        labelSpelling.numberOfLines = 0
        labelSpelling.lineBreakMode = .byWordWrapping
        
        SpellingName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        SpellingName.heightAnchor.constraint(equalToConstant: 17).isActive = true
        SpellingName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 230).isActive = true
        SpellingName.textColor = UIColor.black
        if spellingCountry == nil {
            SpellingName.text = "Undefined"
        }
        else{
            SpellingName.text = spellingCountry?[0]
        }
        SpellingName.font = UIFont(name: "SFPro-Regular", size: 14)
        SpellingName.numberOfLines = 0
        SpellingName.lineBreakMode = .byWordWrapping
    }
   
    func setUpstarckViewCapital() {
        starckViewCapital.widthAnchor.constraint(equalToConstant: 327).isActive = true
        starckViewCapital.heightAnchor.constraint(equalToConstant: 17).isActive = true
        starckViewCapital.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        
        labelCapital.widthAnchor.constraint(equalToConstant: 57).isActive = true
        labelCapital.heightAnchor.constraint(equalToConstant: 17).isActive = true
        labelCapital.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelCapital.text = "Capital:"
        labelCapital.textColor = UIColor.black
        labelCapital.font = UIFont(name: "SFPro-Regular", size: 14)
        labelCapital.numberOfLines = 0
        labelCapital.lineBreakMode = .byWordWrapping
        
        capitalName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        capitalName.heightAnchor.constraint(equalToConstant: 17).isActive = true
        capitalName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 230).isActive = true
        capitalName.textColor = UIColor.black
        if capitalOfCountry == nil {
            capitalName.text = "Undefined"
        }
        else{
            capitalName.text = capitalOfCountry?[0]
        }
        capitalName.font = UIFont(name: "SFPro-Regular", size: 14)
        capitalName.numberOfLines = 0
        capitalName.lineBreakMode = .byWordWrapping
    }
    
    func setUpstarckViewRegion() {
        starckViewRegion.widthAnchor.constraint(equalToConstant: 327).isActive = true
        starckViewRegion.heightAnchor.constraint(equalToConstant: 17).isActive = true
        starckViewRegion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        
        labelRegion.widthAnchor.constraint(equalToConstant: 57).isActive = true
        labelRegion.heightAnchor.constraint(equalToConstant: 17).isActive = true
        labelRegion.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelRegion.text = "Region:"
        labelRegion.textColor = UIColor.black
        labelRegion.font = UIFont(name: "SFPro-Regular", size: 14)
        labelRegion.numberOfLines = 0
        labelRegion.lineBreakMode = .byWordWrapping
        
        RegionName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        RegionName.heightAnchor.constraint(equalToConstant: 17).isActive = true
        RegionName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 230).isActive = true
        RegionName.textColor = UIColor.black
        if regionOfCountry == nil {
            RegionName.text = "Undefined"
        }
        else{
            RegionName.text = regionOfCountry
        }
        RegionName.font = UIFont(name: "SFPro-Regular", size: 14)
        RegionName.numberOfLines = 0
        RegionName.lineBreakMode = .byWordWrapping
    }
    
    func setUpstarckViewNeighbors() {
        starckViewNeighbors.widthAnchor.constraint(equalToConstant: 327).isActive = true
        starckViewNeighbors.heightAnchor.constraint(equalToConstant: 17).isActive = true
        starckViewNeighbors.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        
        labelNeighbors.widthAnchor.constraint(equalToConstant: 100).isActive = true
        labelNeighbors.heightAnchor.constraint(equalToConstant: 17).isActive = true
        labelNeighbors.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        labelNeighbors.text = "Neighbors:"
        labelNeighbors.textColor = UIColor.black
        labelNeighbors.font = UIFont(name: "SFPro-Regular", size: 14)
        labelNeighbors.numberOfLines = 0
        labelNeighbors.lineBreakMode = .byWordWrapping
        
        neighborsName.widthAnchor.constraint(equalToConstant: 100).isActive = true
        neighborsName.heightAnchor.constraint(equalToConstant: 17).isActive = true
        neighborsName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 230).isActive = true
        neighborsName.textColor = UIColor.black
        if neighbors == nil {
            neighborsName.text = "Undefined"
        }
        else{
            neighborsName.text = neighbors?[0]
        }

        neighborsName.font = UIFont(name: "SFPro-Regular", size: 14)
        neighborsName.numberOfLines = 0
        neighborsName.lineBreakMode = .byWordWrapping
    }
}
