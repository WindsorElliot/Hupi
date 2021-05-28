# Hupi

![Hupi build](https://github.com/WindsorElliot/Hupi/actions/workflows/swift.yml/badge.svg)

A swift package for use Philips Hue Lights API

## Version

 **⚠ Under in developement.** 

## Usage

Before use, please read the official Philips Hue Documentation at https://developers.meethue.com/develop/application-design-guidance/

and import Hupi and use it

## Avaible Hupi's class:

#### HueHubNetworkDiscover 

the HueHubNetworkDiscover class is use for discover and connect to a Hue bridge, it should be instanciate with appName (your appname for the bridge)

* retrive all Hue 's bridge in the network
    ```swift
    public func retriveHueBridgeInNetwork(completion: @escaping(Result<[Bridge], Error>) -> Void)
    ```

* connect to specified Hue 's bridge in the network

    the String of success result is the username of your app, you need it to send other command to the bridge.

    ```swift
    public func connectHueBridge(_ hueIpAddress: String, completion: @escaping(Result<String, Error>) -> Void)
    ```

## Avaible Hupi's Model class

#### Bridge : 

The representation of the bridge, extends of NSObject.


* id: Unique identifier of the bridge
* internalIpAddress: Bridge's IP address on your network
* macAddress: Bridge Mac Address
* name: The name of the material



    ```swift
    public let id: String
    public let internalIpAddress: String
    public let macAddress: String
    public let name: String
    ```