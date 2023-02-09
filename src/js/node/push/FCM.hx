package js.node.push;
import js.lib.Error;
import haxe.extern.EitherType;
import haxe.DynamicAccess;

@:jsRequire('node-gcm', 'Sender')
extern class FCMSender {
	function new(apiKey:String);

	function sendNoRetry(message:FCMMessage, recipients:Recipients, cb:(Error,Response)->Void):Void; //send, no retry
	@:overload(function(message:FCMMessage, recipients:Recipients, numRetries:Int, cb:(Error,Response)->Void):Void {}) //retries numRetries times
	function send(message:FCMMessage, recipients:Recipients, cb:(Error,Response)->Void):Void; //retries unlimited times
}

@:jsRequire('node-gcm', 'Message')
extern class FCMMessage {
	function new(messageConfig:MessageConfig);

	@:overload(function(data:DynamicAccess<String>):Void {})
	function addData(k:String,v:String):Void;
}

typedef MessageConfig = {
	?collapseKey:String,
	?priority:MessagePriority,
	?contentAvailable:Bool,
	?delayWhileIdle:Bool,
	?timeToLive:Int,
	?restrictedPackageName:String,
	?dryRun:Bool,
	?tag:String,
	?data:DynamicAccess<String>,
	?notification: {
		title: String,
		?icon: String,
		?body: String
		//and list goes on...
	}
}

enum abstract MessagePriority(String) to String {
	var normal;
	var high;
}

typedef Recipients = {
	?to:String,			//A single registration token, notification key, or topic.
	?topic:String,		//A single publish/subscribe topic.
	?condition:String,	//Multiple topics using the condition parameter.
	?registrationTokens: Array<String> //A list of registration tokens. Must contain at least 1 and at most 1000 registration tokens.
}

typedef Response = {
	multicast_id:Float,
	success:Int,
	failure:Int,
	canonical_ids:Int,
	results:Array<{?message_id:String, ?error:String}>
}
