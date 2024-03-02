# Romain Tirbisch
Hi! 

I am a spatial software engineer (VR, AR, XR). I am passionate about swift development. 
In my free time I work on several swift project. Most of them are small and target one main feature. I intend to use them as support for youtube tutorials.
I also work on a big project that is actually an agregation of my other small projects.

# Simple Multipeer Connectivity
Simple Multipeer Connectivity let nearby users connect and send messages.
It is an open source project.

This app is composed of two views (from the user point of view): Session view and Connection view.

<img width="1365" alt="Simple Multipeer Connectivity" src="https://github.com/elf0-fr/SimpleMultipeerConnectivity/assets/74436735/f1909586-8635-406d-af8f-ddf3cbe237bd">

# Views
## Session View
Session view is where users can send and receive messages. They can also see the the list of connected devices.

<img width="1361" alt="Session view" src="https://github.com/elf0-fr/SimpleMultipeerConnectivity/assets/74436735/618a78fa-028b-4c57-94c0-73cfa77b794a">

## Connection View
Connection view is where users can search for nearby devices.

<img width="400" alt="Peer connection notification." src="https://github.com/elf0-fr/SimpleMultipeerConnectivity/assets/74436735/ec983c89-bb88-43d1-8bae-7ec61182fb9c">
<img width="400" alt="Two connected devices." src="https://github.com/elf0-fr/SimpleMultipeerConnectivity/assets/74436735/5248428f-71b8-493c-96a3-da013fadfd80">

# Implementation
I respect the SOLID pattern. Most multipeer connectivity designs one single class for the session, browser and advertiser part. I chose to design 3 classes.
I also respect the MVVM pattern.

