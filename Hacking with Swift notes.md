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
- ```override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { ... }```
- ```override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { ... }```

9. More keyboard commands for IB:
- Shift+Alt+Cmd+= to reset to suggested constraints.
- Alt+Cmd+Return to show the Assistant editor.

10. In order to show a picture from the table, we need to override the function below and set the image in the viewDidLoad of the other view:
- ```override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { ... }```

11. To avoid the images to strech, change "Scale to fill" to "Aspect fit".

12. To remove the Navigation Controller topbar during fullscreen, add these functions below the viewDidLoad of the view:
- override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

- override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

13. We can add a ">" to the right of the row. To do so, choose "Disclosure indicator" from Accesory in the IB.

14. In the viewDidLoad, we can set a title for the navigation controller setting the variable "title".

15. From iOS 11, we can set larger titles. We need add this to the view controller of the landing view, inside the viewDidLoad method:
- ```navigationController?.navigationBar.prefersLargeTitles = true```

16. From iOS 11, to avoid larger titles in a specific view, add this in the viewDidLoad of that view:
- ```navigationItem.largeTitleDisplayMode = .never```

17. In notch-equipped devices, to avoid blank spaces, uncheck the "Safe Area Layout Guide box" in the size inspector. In this project, this is only done when dealing with images.

18. In notch-equipped devices, to hide the home indicator, override the following variable in the chosen view:
- override var prefersHomeIndicatorAutoHidden: Bool {
        return navigationController?.hidesBarsOnTap ?? false
    }

## Project2: Guess the Flag

1. To draw the border of a button, add the following line to the viewDidLoad:
- ```button.layer.borderWidth = 1```

2. To change the color of the border, add this to the viewDidLoad:
- ```button.layer.borderColor = UIColor.lightGray.cgColor```

3. You can add a tag to an IB object. To do so, press Alt+Cmd+4 and look for Tag. You can later retrieve the tag using ```sender.tag```.

4. To add a alert message, we can use code similar to this one:
- let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
present(ac, animated: true)

5. If the handler of the previous code breaks, you must change the declaration of the method with this:
- ```func askQuestion(action: UIAlertAction! = nil) { ... }```

## Project3: Social Media

1. To rename a project in Xcode, follow this guide and rechoose the Info.plist to avoid a build failure:
- https://help.apple.com/xcode/mac/10.0/#/dev3db3afe4f

2. To create a Sharing button we need to add the following line to the viewDidLoad of the view where the button will appear. This code defines the right button of the navigation bar. The selector points to the triggered method:
- ```navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))```

3. The method we need to trigger the sharing action is this one.
- @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

4. The @objc annotation is used to call Swift code with Objective-C.

5. UIActivityViewController refers to the sharing component.

6. We need to modify the Info.plist to avoid the app crashes when we tap on "Save Image". By default, iOS app cannot access the user's photo library. We must add a row with the values "Privacy - Photo Library Additions Usage Description" and, to the right, the description that the user will receive.

## Project4: Easy browser

1. In the first steps to create a web browser we need to:
- Import the WebKit framework.
- Declare a WKWebView variable.
- Override ```override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
}```
- Conform the protocol ```WKNavigationDelegate```

2. In the viewDidLoad method, we can to add the following lines to test the app:
- let url = URL(string: "https://www.hackingwithswift.com")!
webView.load(URLRequest(url: url))
webView.allowsBackForwardNavigationGestures = true

3. If we want to add a popover we need this steps:
- Add ```navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))``` to create the button. When tapped, it triggers the selector method.
- We create the method from the selector ```@objc func openTapped() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }```
Every ```UIAlertAction``` will be an option of the popover. Everyone indludes a handler to trigger a method when pressed except for the cancel one; it just hide the popover.
- Create the method from the ```UIAlertAction``` handlers ```func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }``` 

4. ```ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem``` is used only on the iPad and tells iOS where it should make the action sheet be anchored.

5. To add a toolbar at the bottom of the view, we will add these lines just below the definition of the "Open" button:
- ```let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)``` creates a flexible space.
- ```let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))``` adds the refresh button.
- and ```toolbarItems = [spacer, refresh]``` and 
```navigationController?.isToolbarHidden = false```.

6. To create a progress bar we need to:
- Declare a ```UIProgressView``` variable.
- Add these lines to the viewDidLoad (just before the ```let spacer``` in this case) ```progressView = UIProgressView(progressViewStyle: .default)
progressView.sizeToFit()
let progressButton = UIBarButtonItem(customView: progressView)```
- Update the toolbar items to add the progress bar: ```toolbarItems = [progressButton, spacer, refresh]```
- Add a observer to check the value of the estimated progress ```webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)```
- Implement this method: ```override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webView.estimatedProgress)
    }
}```

7. We can decide what to do with a web request using:
- this method ```func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
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
}```. If the link does not point to a controlled web, it won't load.