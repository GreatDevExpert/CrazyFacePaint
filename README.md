App
===

Ninjafish application. 


File Structure
--------------
```
.
├── App
    └── Classes - app specific code classes
    └── Resources
      └── Json
      └── Images
      └── Sounds
    └── Icon.png 				// Apple's icon naming convention + suggested/common location for such assets. 
    └── Icon@2x.png
    └── Icon-72.png
    └── Icon-144.png
    └── iTunesArtwork - 1024x1024 app icon, no file extension.
├── App.xcodeproj
├── App.xcworkspace
├── AppTests
├── Podfile
├── Pods - third party libraries
   
```


Resources
---------
### JSON
* Static json files are used to describe app behavior known in advance.
* Refer to associated [Json Schema](http://json-schema.org) files for description of each json file. 
* Schema files have a .schema.json suffix.
* Fields such as 'images_key_paths' in Products.json use [JSONPath](http://goessner.net/articles/JsonPath/) syntax.
* Syntax of any JSONPath values can be checked [here](http://jsonpath.curiousconcept.com).

### Images
* If a screen closely resembles that of one of our other app's, then use the same directory structure for resources used by this screen. 
* Same goes for above with regard to Sounds, however for sounds, the actual file names should match (Use most recently released app to go off). 
* Use [ninjafish command-line tool](https://github.com/ninjafishstudios/ninjafish) to sort images and to verify correct structure once sorted. 
* [Example sorted Images folder](https://github.com/ninjafishstudios/WaffleMaker/tree/develop/App/Resources/Images/)
* Diff command can be used to compare two Images directory structures that should be identical, for example:

---

$ diff -r AnimalDentist/App/Resources/Images/ MonsterDentist/App/Resources/Images/ | grep Only\ in\ Monster



### Guide Images
* Provide guide layouts for every screen in the app.
* Located at App/Resources/Images/guides.
* Provide logical order of screens as part of image name (e.g. 1_choose_flavor~ipad.png, 2_choose_shape~ipad.png).
* Avoid prepositions in images names (e.g. 1_choose_flavor~ipad.png rather than 1_choose_a_flavor~ipad.png) - NB: rationale = since code class names are automatically generated from guide images, helps to conform to coding style. 
* If guide image is for a screen the resembles one of our other app's, then find the class name that screen in the most recent app and name the guide image accordingly.(e.g. if the screen is CookerViewController.h/CookerViewController.m in the recent app, then name the guide image: 'Cooker~ipad.png')
* Where logical and possible, same guide image name as the name of folder in Images/ that encloses resources for that screen (e.g. 1_choose_flavor.png might be guide image for screen ChooseFlavorViewController, with images located at Images/choose_flavor/).
* [Example guide images](https://github.com/ninjafishstudios/WaffleMaker/tree/develop/App/Resources/Images/guides) for app with [Images Folder](https://github.com/ninjafishstudios/WaffleMaker/tree/develop/App/Resources/Images/)


### Product IDs
* Should be of the form: com.ninjafish.moviestarmakeover.unlock_all_lipstick


### Sounds
* Sounds/raw folder may contain a large number of sounds. Consolidate into list of sounds that the app will need (having extra sounds made or pulling sounds from other apps if need be). 
* Sounds listed in Sounds/raw folder will be automatically converted from .wav to appropriate format and placed in Sounds/converted.


Actions Before Beginning Coding
-------------------------------
Run the following command
~~~ sh
$ nf pre_coding
~~~

* Rename project and workspace name (e.g. App->WaffleMaker)
* Import any unreferenced Resources
* nf remove_references; # removes project references to downloadable resources
* Create UserSession Object. 


Dependency Management
---------------------
 
Use [cocoapods](http://cocoapods.org) to manage third party libraries and dependencies.

Example (save in file named 'Podfile' in project directory root):
```ruby
platform :ios
pod 'ChartboostSDK', '~> 3.0'
pod 'ShareKit',       '~> 2.0'
```

### Managing Local Libraries

When using any libraries that will be modified in the process of building/updating this app, first pull a developent branch to the **Pods/Local Pods** directory, then link this library in the Podfile as follows:


```ruby
pod 'NFLibrary', :local => 'Pods/Local Pods/NFLibrary'

```

After adding new files to local libraries managed through cocoapods, run:
~~~ sh
$ pod update
~~~

Create a feature branch named after the application (e.g. feature/cookiemaker) to track changes. 


### Unit Testing
[Getting unit testing to work after CocoaPods is setup](http://samwize.com/2012/10/01/unit-tests-with-cocoapods/)

When changing project name in Xcode, update certain fields in AppTests build settings don't automatically get updated causing a link error when running unit tests. 
To resolve, go into build settings for the unit tests target, remove any references to previous app name (e.g. App.app, App-Prefix.pch..) 

### GHUnit
http://samwize.com/2012/10/04/how-to-setup-ghunit-with-cocoapods/


Documentation
-------------

When document shared libraries such as NFLibrary, use [appledoc](http://gentlebytes.com/appledoc/) conventions since files are automatically parsed and added to local Xcode documentation. Documentation is added by [cocoapods](http://cocoapods.org), when running 'pod install' for example. 
Appledoc must be [installed](https://github.com/tomaz/appledoc#quick-install) on local machine for documentation to be generated. 



Conventions
-----------

Project name should be camelcase version of Bundle Identifer; workspace and repo name should match project name. E.g. if bundle identifier is: com.ninjafishstudios.cookiemaker, then project, workspace, and git repo name should be CookieMaker.

### Objective-C Style Guide
http://google-styleguide.googlecode.com/svn/trunk/objcguide.xml

(except: comments, line length, spaces)

### Comments
[Appledoc comment formatting](http://gentlebytes.com/appledoc-docs-comments/)

### JSON Style Guide
http://google-styleguide.googlecode.com/svn/trunk/jsoncstyleguide.xml




Actions Before Submitting to Apple
----------------------------------
Run the following command
~~~ sh
$ nf post_coding
~~~

* Check AWS
* Run on every major OS release starting from minimum target OS. 
* Scan for use of Apple private APIs
* Check that App Store screenshots have been submitted to iTunes connect. 


Other Tools
-----------
* [Objectify](http://tigerbears.com/objectify/) - automatically creates Objective-C class code from JSON (includes support for NSCoding). 
* [ninjafish](https://github.com/ninjafishstudios/ninjafish) command line tool. Validate project json, image folder structure, create json image index file, code generation (such as sound constansts), etc.



Copyright
---------

Copyright (c) 2013 Ninjafish Studios LLC.

