onmessage = function(e) {
	console.log("Worker: Message received");
	postMessage('a');
}