var elements = {
  servername: document.getElementById('servername'),
  maxplayers: document.getElementById('maxplayers'),
  mapname: document.getElementById('mapname'),
  loading: document.getElementById('loading'),
  overlay: document.getElementById('background-overlay')
}
elements.loadingStatus = elements.loading.getElementsByClassName('loading-status')[0];
elements.loadingBar = elements.loading.getElementsByClassName('loading-bar')[0];

var filesTotal = 1;

function GameDetails( servername, serverurl, mapname, maxplayers, steamid, gamemode ) {
  elements.servername.textContent = servername;
  elements.maxplayers.textContent = maxplayers;
  elements.mapname.textContent = mapname;
}

function SetFilesTotal( total ) {
  filesTotal = total
}
/*
 Called when the client starts downloading a file.

 fileName- The full path and name of the file the client is downloading.
 This path represents the resource's location rather than the actual file's location on the server.
 For example, the file "garrysmod/addons/myAddon/materials/models/bobsModels/car.mdl" will be:
 "materials/models/bobsModels/car.mdl"
 */
function DownloadingFile( fileName ) {}
/*
 Called when the client's joining status changes.

 status- Current joining status.
 For example: "Sending client info..."
 */
function SetStatusChanged( status ) {}
/*
 Called when the number of files remaining for the client to download changes.

 needed- Number of files left for the client to download.
 */
function SetFilesNeeded( needed ) {
  var filesRemaining = Math.max(0, filesTotal - needed);
  var progress = filesTotal > 0 ? (filesRemaining / filesTotal) : 1;

  progress = Math.round(progress * 100);

  elements.loadingStatus = progress + '%';
  elements.loadingBar = (100 - progress) + '%';
}

var backgrounds = ['bg1.jpg', 'bg2.jpg', 'bg3.jpg'];
var currentBackgroundIndex = 0;

setInterval(function() {
  currentBackgroundIndex = currentBackgroundIndex === backgrounds.length - 1 ? 0 : currentBackgroundIndex + 1;

  var newBackgroundRule = 'url("backgrounds/'+backgrounds[currentBackgroundIndex]+'")';
  elements.overlay.style.backgroundImage = newBackgroundRule;

  animateShowOpacity(elements.overlay, function(elem) {
    document.body.style.backgroundImage = newBackgroundRule;
    elem.style.opacity = '0';
  })
}, 5000)

function animateShowOpacity(elem, cb){
  var interId = setInterval(function() {
    if(elem.style.opacity === '1'){
      clearInterval(interId);
      if (cb) { cb(elem) }
    } else {
      elem.style.opacity = parseFloat(elem.style.opacity) + 0.1;
    }
  }, 300)
}
