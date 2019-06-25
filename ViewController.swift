import UIKit
class ViewController: UIViewController {
    var page:Int = 1
    var index:Int = 1
    var selection:Int = 1
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var titles: UIImageView!
    @IBOutlet weak var contents: UIImageView!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var bible: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" ====  \(self.getLanguageType())")
        UserDefaults.standard.set(true, forKey: "diagnosis_finished")
        titles.alpha = 0.75
        contents.alpha = 0.75
        text.isHidden = false
        text.isEditable = false
        bible.isHidden = false
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        contents.addGestureRecognizer(longGesture)
        let bibleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bibleTapped(tapGestureRecognizer:)))
        bible.isUserInteractionEnabled = true
        bible.addGestureRecognizer(bibleTapGestureRecognizer)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        titles.isUserInteractionEnabled = true
        titles.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
        contents.isUserInteractionEnabled = true
        contents.addGestureRecognizer(tapGestureRecognizer2)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
    }
    @objc func longTap(_ sender: UIGestureRecognizer){
        var  headerFix = ""
        let lanStr = self.getLanguageType()
        if lanStr.isEqual("ja") {
          headerFix = "JAN"
        }else if lanStr.isEqual("ja"){
            headerFix = "KOR"
        }else if lanStr.isEqual("fr"){
            headerFix = "Fr"
        }else if lanStr.isEqual("de"){
            headerFix = "Ger"
        }else{
            headerFix = ""
        }
        let s = try! String(contentsOfFile: Bundle.main.path(forResource:String(headerFix) + "S" + String(index) + "E" + String(selection), ofType: "txt")!)
        print("Long tap")
        if sender.state == .ended {
            print("UIGestureRecognizerState Ended")
        }
        else if sender.state == .began {
            print("UIGestureRecognizerState Began.")
            text.text = s;
            text.isHidden = false;
            titles.isHidden = true;
            contents.isHidden = true;
            logo.isHidden = true;
        }
    }
    @objc func bibleTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        var  headerFix = ""
        let lanStr = self.getLanguageType()
        if lanStr.isEqual("ja") {
            headerFix = "JAN"
        }else if lanStr.isEqual("ja"){
            headerFix = "KOR"
        }else if lanStr.isEqual("fr"){
            headerFix = "Fr"
        }else if lanStr.isEqual("de"){
            headerFix = "Ger"
        }else{
            headerFix = ""
        }
        print("bible tapped")
        let s = try! String(contentsOfFile: Bundle.main.path(forResource:String(headerFix) + "S" + String(index) + "E" + String(selection), ofType: "txt")!)
        text.text = s;
        text.isHidden = false;
    }
    @objc func backTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("back tapped")
        text.isHidden = true;
        titles.isHidden = false;
        contents.isHidden = false;
        logo.isHidden = false;
        bible.isHidden = false;
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        if index > 7{
            index = 1;
        }else{
            index = index + 1;
        }
        selection = 1;
        print("title tapped")
        print(index)
        displayTitle(titleNumber: index)
    }
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        if selection > 4{
            selection = 1;
        }else{
            selection = selection + 1;
        }
        print("content tapped")
        print(selection)
        displayContent(contentNumber: selection)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if page > 1{
                    page = page - 1
                }
                print("Page Swiped right")
                print(page)
                displayImage(pageNumber: page)
            case UISwipeGestureRecognizer.Direction.down:
                if page > 1{
                    page = page - 1
                }
                print("Page Swiped down")
                print(page)
                displayImage(pageNumber: page)
            case UISwipeGestureRecognizer.Direction.left:
                if page < 4{
                    page = page + 1
                }
                print("Page Swiped left")
                print(page)
                displayImage(pageNumber: page)
            case UISwipeGestureRecognizer.Direction.up:
                if page < 4{
                    page = page + 1
                }
                print("Page Swiped up")
                print(page)
                displayImage(pageNumber: page)
            default:
                break
            }
        }
    }
    func displayImage(pageNumber:Int){
    }
    func displayTitle(titleNumber:Int){
        titles.image = UIImage(named: String(titleNumber) + ".png")
        contents.image = UIImage(named: String(titleNumber) + "-1.png")
    }
    func displayContent(contentNumber:Int){
        contents.image = UIImage(named: String(index) + "-" + String(contentNumber) + ".png")
    }
    func getLanguageType() -> String {
        let def = UserDefaults.standard
        let allLanguages: [String] = def.object(forKey: "AppleLanguages") as! [String]
        let chooseLanguage = allLanguages.first
       let chossLan = chooseLanguage?.components(separatedBy: "-").first
        return chossLan ?? "en"
    }
}
