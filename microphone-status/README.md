Microphone Status
=================

I wanted a simple app that would show me if my microphone was muted or not so I created this.

Usage (draft)
-----

* First in `support` you'll see a `soundcard_vista` folder. Run that (requires vista or higher) to get a list of devices.
* Look for your microphone device. It may help to open up recording properties and look at the volume setting for your microphone. If you choose the right one and hit the toggle button you'll see the mic muted in recording devices
* At the bottom you'll see something like `SoundGet, OutputVar, Master, Mute 8`. This means your mic is device number `8` and the component type is `Master`
* Open up `config.ini` in a text editor and put those two values in.

Credits
-------

* Mic icons came from [Rob Cameron](http://ridingtheclutch.com/post/50426862116/a-couple-of-my-icons-make-it-into-font-awesome) which are also part of [Font Awesome](http://fortawesome.github.io/Font-Awesome/icons/)
