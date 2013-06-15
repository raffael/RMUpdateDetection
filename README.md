RMUpdateDetection
=================

Easy app version transition recognizer with delegate pattern.

## Usage

1. Import the ```RMUpdateDetection.h``` in your application.
2. Download and import @danhanly's awesome ```VersionComparator``` library from, e.g. GitHub: https://github.com/danhanly/VersionComparator
3. In your ```-(void) applicationDidFinishLoading;```method, set the delegate and trigger the checking.

```
	[[RMUpdateDetection sharedInstance] setDelegate:self];
	[[RMUpdateDetection sharedInstance] check];
```

4. Implement the delegate protocol, e.g.:

```
		- (void) userDidUpdateFrom: (NSString *) oldVersion to: (NSString *) currentVersion {
			// Hurray, the user did update to our most recent version!
	}
```

That's it!

## Contact

* Raffael Hannemann
* [@raffael_me](http://www.twitter.com/raffael_me/)
* http://www.raffael.me/

## License

Copyright (c) 2013 Raffael Hannemann
Under BSD License.

## Want more?

Follow [@raffael_me](http://www.twitter.com/raffael_me/) for similar releases.