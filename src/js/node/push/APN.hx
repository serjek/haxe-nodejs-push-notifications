package js.node.push;
import js.lib.Promise;
import haxe.extern.EitherType;
import haxe.DynamicAccess;

//By default, the provider will connect to the sandbox unless
//the environment variable NODE_ENV=production is set.

@:jsRequire('apn', 'Provider')
extern class APNProvider {
	function new(config:ProviderConfig);
	function send(notif:APNNotification, deviceToken:DeviceToken):Promise<SendResult>;
}

@:jsRequire('apn', 'Notification')
extern class APNNotification {
	function new(config:NotificationConfig);
	//also has list of setters
}

typedef DeviceToken = Array<String>;
typedef SendResult = {
	sent:Array<Dynamic>,
	failed:Array<Dynamic>
}

typedef ProviderConfig = {
	token: {
		key:String, //"path/to/APNsAuthKey_XXXXXXXXXX.p8",
		keyId:String, //
		teamId:String //"developer-team-id"
	},
	?proxy: {
		host:String,//"192.168.10.92",
		port:Int//8080
	},
	production:Bool
}

typedef NotificationConfig = {
	?expiry:Int,
	?priority:Int, 	//either 5 or 10
					//10 - The push notification is sent to the device immediately. (Default)
					//5 - The push message is sent at a time that conserves power on the device receiving it.
	?badge:Int,
	?sound:String,
	?alert:EitherType<
		String,
		{
			body:String,
			title:String,
			action:String
		}
	>,
	topic:String, //Required: The destination topic for the notification - bundle identifer
	?payload:DynamicAccess<String>,
	?collapseId:String //Multiple notifications with same collapse identifier are displayed to the user as a single notification. The value should not exceed 64 bytes.
	//list goes on...
}