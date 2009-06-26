var username = 'bavardage';
var reponame = 'kiloseconds';
var api_url = 'http://github.com/api/v2/json/';


function get_blob(sha_id, path, callback) {
    // calls callback with the blob object

    url = api_url + 'blob/show/' + username + '/' + reponame + '/' + sha_id + '/' + path + '?callback=?';

    $.getJSON(url, 
	      function(data) {
		  callback(data.blob);
	      }
	      );
}

function get_branches(callback) {
    url = api_url + 'repos/show/' + username + '/' + reponame + '/branches?callback=?';
    $.getJSON(url,
	      function(data) {
		  callback(data.branches);
	      }
	      );
}

function get_master_sha_id(callback) {
    get_branches(function (branches) {
	    callback(branches['master']);
	});
}

function get_tree(sha_id, callback) {
    //calls callback with the tree object
    
    url = api_url + 'tree/show/' + username + '/' + reponame + '/' + sha_id + '?callback=?';

    $.getJSON(url,
	      function(data) {
		  callback(data.tree);
	      }
	      );
}

function debug(text) {
    //    $('#debug').append(text + '<br/>');
}

function test() {
    show_implementations();
}

function show_implementations() {
    function process_master_tree(treeitems) {
	$.each(treeitems, function(i, item) {
		if(item.type=='tree') {
		    $('#implementations').append(
		     '<li id="' + item.sha + '"><span onClick="expand_language(\'' + item.sha + '\')";>' + item.name + '</span></li>'
		    );
		}
	    });
    }

    function process_master_sha_id(sha_id) {
	get_tree(sha_id, process_master_tree);
    }

    get_master_sha_id(process_master_sha_id);
}

function expand_language(id) {
    $('#' + id).append('<ul></ul>');

    function process_language_tree(treeitems) {
	$.each(treeitems, function(i, item) {
		if(item.type = 'blob') {
		    $('#' + id + ' ul').append(
		      '<li id="' + item.sha + '">'
		      + '<span onclick="show_implementation(\'' + id + '\', \'' + item.name + '\')">'
		      + item.name 
		      + '</span>'
		      + '</li>'
		    );
		}
	    });
    }
    
    get_tree(id, process_language_tree);
}

function show_implementation(tree_sha, path) {
    function show_blob(blob) {
	debug('<div>' + blob.data + '</div>');
	text = '<h1>' + blob.name + '</h1>';
	text += '<pre>' + blob.data + '</pre>';
	show_popup(text);
    }
    
    get_blob(tree_sha, path, show_blob);
}

function show_popup(text) {

    $('#popup').fadeOut('fast');

    $('#popupText').html(text);

    var windowWidth = window.innerWidth; //document.documentElement.clientWidth;  
    var windowHeight = window.innerHeight; //document.documentElement.clientHeight;  
    var popupHeight = windowHeight * 0.8;
    var popupWidth = windowWidth * 0.8;

    debug('height' + popupHeight);
    


    $("#popup").css({
	    'position': 'absolute',
	    'top': windowHeight/2-popupHeight/2,  
	    'left': windowWidth/2-popupWidth/2,
		});
    $('#popupText div').css({
	    'width': popupWidth,
	    'max-height': popupHeight,
		});
    $('#popup').fadeIn('fast');
}