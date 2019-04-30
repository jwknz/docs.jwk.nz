var anchors = document.querySelectorAll('a');

for (var i = 0; i < anchors.length; i++) {
	if (anchors[i].host !== window.location.hostname) {
		anchors[i].setAttribute('target', '_blank');
 	}
}