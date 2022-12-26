For Android (terminal): Deep Links:

    1. navigation to screen one without passing ID parameter
	command: adb shell am start -a android.intent.action.VIEW \
        		-c android.intent.category.BROWSABLE \
        		-d "flutterdeeplinkingdemo://dharam.com/screen-one"

    2. navigation to screen one with passing ID parameter
	command: adb shell am start -a android.intent.action.VIEW \
        		-c android.intent.category.BROWSABLE \
        		-d "flutterdeeplinkingdemo://dharam.com/screen-one/123”

    3. navigation to screen one without passing ID parameter
	command: adb shell am start -a android.intent.action.VIEW \
        		-c android.intent.category.BROWSABLE \
        		-d "flutterdeeplinkingdemo://dharam.com/screen-two”

    4. navigation to screen one with passing ID parameter
	command: adb shell am start -a android.intent.action.VIEW \
        		-c android.intent.category.BROWSABLE \
        		-d "flutterdeeplinkingdemo://dharam.com/screen-two/123”

———————————————————————————————————————————————————————

For iOS (terminal): Custom URL schemes:

    1. navigation to screen one without passing ID parameter
	command: xcrun simctl openurl booted flutterdeeplinkingdemo://dharam.com/screen-one

    2. navigation to screen one with passing ID parameter
	command: xcrun simctl openurl booted flutterdeeplinkingdemo://dharam.com/screen-one/123

    3. navigation to screen two without passing ID parameter
	command: xcrun simctl openurl booted flutterdeeplinkingdemo://dharam.com/screen-two

    4. navigation to screen two with passing ID parameter
	command: xcrun simctl openurl booted flutterdeeplinkingdemo://dharam.com/screen-two/123 


Contact me if you’re having any issue.
