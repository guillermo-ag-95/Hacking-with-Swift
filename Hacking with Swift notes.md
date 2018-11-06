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
- override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { ... } 
- override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { ... }

9. More keyboard commands for IB:
- Shift+Alt+Cmd+= to reset to suggested constraints.
- Alt+Cmd+Return to show the Assistant editor.

10. In order to show a picture from the table, we need to override the function below and set the image in the viewDidLoad of the other view:
- override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { ... }

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
- navigationController?.navigationBar.prefersLargeTitles = true

16. From iOS 11, to avoid larger titles in a specific view, add this in the viewDidLoad of that view:
- navigationItem.largeTitleDisplayMode = .never

17. In notch-equipped devices, to avoid blank spaces, uncheck the "Safe Area Layout Guide box" in the size inspector. In this project, this is only done when dealing with images.

18. In notch-equipped devices, to hide the home indicator, override the following variable in the chosen view:
- override var prefersHomeIndicatorAutoHidden: Bool {
        return navigationController?.hidesBarsOnTap ?? false
    }

## Project2: Guess the Flag

1. To draw the border of a button, add the following line to the viewDidLoad:
- button.layer.borderWidth = 1

2. To change the color of the border, add this to the viewDidLoad:
- button.layer.borderColor = UIColor.lightGray.cgColor

3. You can add a tag to an IB object. To do so, press Alt+Cmd+4 and look for Tag. You can later retrieve the tag using sender.tag.

4. To add a alert message, we can use code similar to this one:
- let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
present(ac, animated: true)

5. If the handler of the previous code breaks, you must change the declaration of the method with this:
- func askQuestion(action: UIAlertAction! = nil) { ... }
