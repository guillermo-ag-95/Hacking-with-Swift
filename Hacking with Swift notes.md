# Hacking with Swift notes

## Project1: Storm Viewer

1. Keyboard commands to start and stop the build:
- Cmd+R to run the project.
- Cmd+. (dot) to stop the project.

2. When we add some files to the workspace:
- Check "Copy items if needed".
- Check "Create groups".

3. Xcode bug:
- When we select an images, the checkbox beneath "Target Membership" must be checked. To access to this checkbox press Alt+Cmd+1.

4. FileManager let us work with the filesystem of the app.

5. Bundle.main.resourcePath! retrieves the path of the assets used in the project.

6. fm.contentsOfDirectory(atPath: path), with fm being a FileManager object, retrieves all the items of the given directory.

7. Keyboard commands for Interface Builder:
- Cmd+Shift+L to open the object library.
- Alt+Cmd+Shift+L to keep the object library open after dragging an object.
- Alt+Cmd+3 to open the Identity inspector.
- All+Cmd+4 to open the Attributes inspector.

8. In order to make the table work, we need to override two functions:
```
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { ... }
```
```
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { ... }
```

9. More keyboard commands for IB:
- Shift+Alt+Cmd+= to reset to suggested constraints.
- Alt+Cmd+Return to show the Assistant editor.

10. In order to show a picture from the table, we need to override the function below and set the image in the viewDidLoad of the other view:
```
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { ... }
```

11. To avoid the images to strech, change "Scale to fill" to "Aspect fit".

12. To remove the Navigation Controller topbar during fullscreen, add these functions below the viewDidLoad of the view:
```
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
}
```

```
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
}
```

13. We can add a ">" to the right of the row. To do so, choose "Disclosure indicator" from Accesory in the IB.

14. In the viewDidLoad, we can set a title for the navigation controller setting the variable "title".

15. From iOS 11, we can set larger titles. We need add this to the view controller of the landing view, inside the viewDidLoad method:
- ```navigationController?.navigationBar.prefersLargeTitles = true```

16. From iOS 11, to avoid larger titles in a specific view, add this in the viewDidLoad of that view:
- ```navigationItem.largeTitleDisplayMode = .never```

17. In notch-equipped devices, to avoid blank spaces, uncheck the "Safe Area Layout Guide box" in the size inspector. In this project, this is only done when dealing with images.

18. In notch-equipped devices, to hide the home indicator, override the following variable in the chosen view:
```
override var prefersHomeIndicatorAutoHidden: Bool {
    return navigationController?.hidesBarsOnTap ?? false
}
```

## Project2: Guess the Flag

1. To draw the border of a button, add the following line to the viewDidLoad:
- ```button.layer.borderWidth = 1```

2. To change the color of the border, add this to the viewDidLoad:
- ```button.layer.borderColor = UIColor.lightGray.cgColor```

3. You can add a tag to an IB object. To do so, press Alt+Cmd+4 and look for Tag. You can later retrieve the tag using ```sender.tag```.

4. To add a alert message, we can use code similar to this one:
```
let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
present(ac, animated: true)
```

5. If the handler of the previous code breaks, you must change the declaration of the method with this:
```
func askQuestion(action: UIAlertAction! = nil) { ... }
```

## Project3: Social Media

1. To rename a project in Xcode, follow this guide and rechoose the Info.plist to avoid a build failure:
- https://help.apple.com/xcode/mac/10.0/#/dev3db3afe4f

2. To create a Sharing button we need to add the following line to the viewDidLoad of the view where the button will appear. This code defines the right button of the navigation bar. The selector points to the triggered method:
- ```navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))```

3. The method we need to trigger the sharing action is this one.
```
@objc func shareTapped() {
    let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
}
```

4. The @objc annotation is used to call Swift code with Objective-C.

5. UIActivityViewController refers to the sharing component.

6. We need to modify the Info.plist to avoid the app crashes when we tap on "Save Image". By default, iOS app cannot access the user's photo library. We must add a row with the values "Privacy - Photo Library Additions Usage Description" and, to the right, the description that the user will receive.

## Project4: Easy browser

1. In the first steps to create a web browser we need to:
- Import the WebKit framework.
- Declare a WKWebView variable.
- Override

 ```
 override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
}
```
- Conform the protocol ```WKNavigationDelegate```

2. In the viewDidLoad method, we can to add the following lines to test the app:
```
let url = URL(string: "https://www.hackingwithswift.com")!
webView.load(URLRequest(url: url))
webView.allowsBackForwardNavigationGestures = true
```

3. If we want to add a popover we need this steps:
- Add ```navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))``` to create the button. When tapped, it triggers the selector method.
- We create the method from the selector
```
@objc func openTapped() {
    let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
}
```
Every ```UIAlertAction``` will be an option of the popover. Everyone indludes a handler to trigger a method when pressed except for the cancel one; it just hide the popover.
- Create the method from the ```UIAlertAction``` handlers
```
func openPage(action: UIAlertAction) {
    let url = URL(string: "https://" + action.title!)!
    webView.load(URLRequest(url: url))
}
``` 

4. ```ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem``` is used only on the iPad and tells iOS where it should make the action sheet be anchored.

5. To add a toolbar at the bottom of the view, we will add these lines just below the definition of the "Open" button:
- ```let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)``` creates a flexible space.
- ```let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))``` adds the refresh button.
- and ```toolbarItems = [spacer, refresh]``` and 
```navigationController?.isToolbarHidden = false```.

6. To create a progress bar we need to:
- Declare a ```UIProgressView``` variable.
- Add these lines to the viewDidLoad (just before the ```let spacer``` in this case)
```
progressView = UIProgressView(progressViewStyle: .default)
progressView.sizeToFit()
let progressButton = UIBarButtonItem(customView: progressView)
```
- Update the toolbar items to add the progress bar
```
toolbarItems = [progressButton, spacer, refresh]
```
- Add a observer to check the value of the estimated progress
```
webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
```
- Implement this method
```
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webView.estimatedProgress)
    }
}
```

7. We can decide what to do with a web request using this method:
```
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url
    if let host = url?.host {
        for website in websites {
            if host.contains(website) {
                decisionHandler(.allow)
                return
            }
        }
    }
    decisionHandler(.cancel)
}
```
If the link does not point to a controlled web, it won't load.

## Project5: Word Scramble

1. To add info from a txt we need to follow three steps:
- Find the path of the file.
- Load the data.
- Split the data.

2. To find the path we will use the method ```Bundle.main.path(fromResource:)```

3. To load the data, we can create the array with the return of the previous method.

4. To split the data, we can use ```components(separatedBy:)``` with '/n' as the separator.

5. We can choose a random string from an array using ```.randomElement()```

6. To empty an array without reducing its memory size, use ```.removeAll(keepingCapacity: true)```

7. Use ```unowned``` when passing an external variable to a closure. If not, we can create an cycle (Object A needs B and B needs A).

8. We can use ```reloadData()``` to reload the table but that's not efficient if we only want to add a row. We should use ```let indexPath = IndexPath(row: 0, section: 0) tableView.insertRows(at: [indexPath], with: .automatic)```

9. The ```IndexPath``` object contains the row and section of every item of a table.

10. To spot spelling mistakes we can use this method:
```
func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSMakeRange(0, word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
}
```

11. If we are counting anything from our code, use ```String.count```. If you are counting from an user input, use ```String.uft16.count```

## Project6: Auto Layout

1. To choose what device orientation we want to support, press Cmd+1, select "General" at the top and look for "Device Orientation".

2. We can set constraints to be not only equal, but greater-than-equal or less-than-equal. This will create constraints like "keep this separation of 20 points or more". To do so, choose an constraint and press Cmd+Alt+4. The selector is named "Relation" under "Bottom Alignment Constraint".

3. To keep a relation between the height or width of two objects we can set "Equal Heights" and "Equal Width" constraints.

4. To keep the aspect ratio of an object, we can set an "Aspect Ratio" constraints.

5. If we create constraints using code, we need to set `translatesAutoresizingMaskIntoConstraints` to false. With this, we will ignore Auto Layout constraints for this object.

6. `sizeToFit()` adjusts the object size to its content.

7. The module used to code constraints is named Auto Layout Visual Format Language (VFL):
- First, we create a dictionary [String:UILabel] that, for every label object we archive its name. Let's say: ["Label1": label1].
- Second, we add constraints
```
for label in viewsDictionary.keys {
    view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
}
```
- The `withVisualForm` parameter is used to introduce the VFL syntax. `H:|[\(label)]|` means: "Horizontally (H:), from edge (|) to edge (|).
- Third, we add the vertical constraints
```
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(==88)]-[label2(==88)]-[label3(==88)]-[label4(==88)]-[label5(==88)]-(>=10)-|", options: [], metrics: nil, views: viewsDictionary))
```
- Here, we can define the height of every object and the space from the bottom [-(>=10)-].

8. Where metrics, we can add another dictionary to avoid these multiples hardcoded values. Let's define a `let metrics = ["labelHeight": 88]` and pass it using the metrics parameter. We also need to change the constraints to use the dictiorary: `V:|[label1(labelHeight)]-[la`...

9. To set a different priority to a constraint (deafult = 1000, then down to 1), we can add an `@999` to set the priority to any number: `V:|[label1(labelHeight@999)]-[la`...

10. We can also use Auto Layout anchors as a way to set constraints:

```
var previous: UILabel?

for label in [label1, label2, label3, label4, label5] {
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalToConstant: 88).isActive = true

    if let previous = previous {
        // we have a previous label – create a height constraint
        label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
    }

    // set the previous label to be the current one, for the next loop iteration
    previous = label
}
```

## Project7: Whitehouse Petitions

1. When we add a Navigation Controller and a Tab Bar Controller to the Storyboard, we first select "Embed in > Navigation controller" and just next "Embed in > Tab bar controller". With this, Navigation Controller will be inside a Tab bar too.

2. To change the Tab Bar icon, click on its icon in the Navigation Controller view (clicking in the Tab Bar one won't trigger the `UITabBarItem`).

3. We can work with JSON if our struct conforms to `Codable`.

4. Steps to retrieve the data from an API:
- Add the API URL to the viewDidLoad.
- Create a `URL` object with the URL string using `if let { ... }`.
- Create a `Data` object with the content from the `URL` using `if let` and `try?` because we might get an error.

5. To parse the data from JSON to Swift we need to create a `parse()` function. Here we:
- Create a `JSONDecoder()`.
- Decode the data `if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) { ... }`.
- Update the values: `petitions = jsonPetitions.results tableView.reloadData()`.

6. To update the cell with the new information, we need to change code from the `cellForRowAt` method:
```
let petition = petitions[indexPath.row]
cell.textLabel?.text = petition.title
cell.detailTextLabel?.text = petition.body
```

7. To pass information from the table to the detail view, we need to override the `didSelectRowAt` method:
```
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
```

8. To add a second `UITabBarItem` without usign IB, we need to modify `didFinishLaunchingWithOptions` method in `AppDelegate.swift`:
```
if let tabBarController = window?.rootViewController as? UITabBarController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            tabBarController.viewControllers?.append(vc)
        }
```
## Project8: 7 Swifty Words

1. If you want to resize a Text Field object, you need to set it borderless.

2. Instead of creating one outlets for every button (20 outlets in this case), we can use the tag. We loop through the subviews where `subview.tag == 1001`
```
for subview in view.subviews where subview.tag == 1001 {
    let btn = subview as! UIButton
    letterButtons.append(btn)
    btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
}
```

3. Using `UIButton.addTarget(...)` let us attach a method to the button. This is the code way to Crtl-Drag in the Storyboard.

## Project 9: Grand Central Dispatch

1. If we want to send a chunck of code to the background, we need to call `async()` using the GCD.
```
DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            return
        }
    }
}

showError()
```

2. If we want to update anything related to the interface, we need to use
```
DispatchQueue.main.async { [unowned self] in
...
}
```

3. Another way of using the GCD is using `performSelector()`. We choose between `performSelector(inBackground:)` and `performSelector(onMainThread:)` to specify what code to run in which thread.
```
override func viewDidLoad() {
    super.viewDidLoad()

    performSelector(inBackground: #selector(fetchJSON), with: nil)
}
```
```
func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    } else {
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
}
```
Every code that is called inside a selector must be defined as an @objc method.

## Project10: Names to Faces

1. In order to create a custom cell you need to:
- Create a custom class with the @IBOutlets attributes.
- In the IB, declare the cell with the custom class type.
- Press Cmd+Alt+6 and Crtl+drag from the right circle to the Storyboard to connect them.

2. As with TableViewController, we need to declare two methods to make CollectionViewController to work
```
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
    return cell
}
```

3. `UIImagePickerController` lets us import pictures to the app. In this code
```
@objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
}
```

setting `picker.allowsEditing = true` is the way to tell the app that we can crop the picture.

4. To conform the `UIImagePickerControllerDelegate` protocol, we need to override a method
```
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else { return }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: imagePath)
    }

    dismiss(animated: true)
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
```

- `UUID().uuidString` returns a unique identifier for that image.
- `getDocumentsDirectory()` is a custom method where we return the app directory where we want to store the image.
- We need to convert from `UIImage` to `Data` in order to store it.

5. To retrieve the data stored in the disk, we need to access the path in the `cellForItemAt` method.
```
let path = getDocumentsDirectory().appendingPathComponent(person.image)
cell.imageView.image = UIImage(contentsOfFile: path.path)
```

## Project11: Pachinko

1. SpriteKit equivalent to IB is named Scene Editor.

2. To the project to a vanilla state we need to:
- Change the code from GameScene.swift
```
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
```
- Change the Anchor point in the Attributes inspector to (X,Y) = (0,0).
- Change the size of the screen to be (W,H) = (1024,768).
- Delete `Actions.sks`.

3. To place an image in a game, we use `SKSpriteNode`.

4. As X and Y is based on the center of a the screen, to place the background we will use (1024/2, 768/2).

5. With `background.zPosition = -1` we place an object behind everything.

6. To add a node to the scene, we use `addChild()`.

7. The `didMove` method is the equivalent to `viewDidLoad` in iOS.

8. `touchesBegan()` includes what happens when we tap the screen, even with multiple fingers.

9. We can add physics to the body with this: `box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))` but we need to also add physics to the scene with this line `physicsBody = SKPhysicsBody(edgeLoopFrom: frame)`

10. If we want to add circular physics to the object we need to use `SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)`

11. `ball.physicsBody?.restitution = 0.4` sets the bounciness of the ball.

12. To make your object spin forever, add this code:
```
let spin = SKAction.rotate(byAngle: .pi, duration: 10)
let spinForever = SKAction.repeatForever(spin)
slotGlow.run(spinForever)
```

13. To add a label to track the score we need to add this code:
```
var scoreLabel: SKLabelNode!

var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```
```
scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
scoreLabel.text = "Score: 0"
scoreLabel.horizontalAlignmentMode = .right
scoreLabel.position = CGPoint(x: 980, y: 700)
addChild(scoreLabel)
```

14. To work with particles, use `SKEmitterNode`.

## Project12: UserDefaults

1. In order to save some data in disk, we use `UserDefaults`. If we want to use this, we need to conform the class to `NSCoding` and complete these methods:
```
required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String
    image = aDecoder.decodeObject(forKey: "image") as! String
}

func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
}
```

2. To save data using `UserDefaults`, we add a new method where we save it using `NSKeyedArchiver`
```
func save() {
    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    }
}
```

3. To retrieve the data, we add this code to the `viewDidLoad`
```
let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
        people = decodedPeople ?? [Person]()
    }
}
```

4. `NSCoding` is used when we have Objective-C code along side with Swift code. When we only have Swift code, `Codable` is a better option.
- `Codable` works with both, structs and classes.
- Unless we need more detail, we don't need to write `encode()` and `decode()` methods.
- `Codable` reads and write in JSON.

5. We just need to conform the class or struct to `Codable` and make the same changes as before but with a few changes.
```
func save() {
    let jsonEncoder = JSONEncoder()
    if let savedData = try? jsonEncoder.encode(people) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    } else {
        print("Failed to save people.")
    }
}
```
```
let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    let jsonDecoder = JSONDecoder()

    do {
        people = try jsonDecoder.decode([Person].self, from: savedPeople)
    } catch {
        print("Failed to load people")
    }
}
```

## Project13: Instafilter

1. If we want to let Xcode choose the suggested IB constraints, choose the `ViewController` and click on `Editor > Resolve Auto Layout Issues > Reset To Suggested Constraints`.

2. If we want to use photos from the camera roll, we need to use this method
```
@objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
}
```
change the Info.plist with a new property: `Privacy - Photo Library Additions Usage Description` and its description and we need to conform the class to the required delegates.
```
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate { ... }
```
Finally, we add the required code of the picker.
```
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    dismiss(animated: true)
    
    currentImage = image
}
```

3. If we want to use `CoreImage` we need to import it: `import CoreImage`. Then, we need to add to variables: The `CIContext` and the `CIFilter`. This variables will be initialize in the `viewDidLoad`:
```
context = CIContext()
currentFilter = CIFilter(name: "CISepiaTone")
```

4. We need to add this code to the end of the `didFinishPickingMediaWithInfo`:
```
let beginImage = CIImage(image: currentImage)
currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

applyProcessing()
```

5. We need to add the `applyProcessing` method to the slider action. This method is the one that add the filter to the image.
```
func applyProcessing() {
    currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)

    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        imageView.image = processedImage
    }
}
```
