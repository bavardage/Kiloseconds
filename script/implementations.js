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

function show_implementations() {
    $('#implementations').addClass('loading');
    $('#implementations').html('<li>loading...</li>');

    function process_master_tree(treeitems) {
	$('#implementations').removeClass('loading');
	$('#implementations').html('');
	$.each(treeitems, function(i, item) {
		if(item.type=='tree') {
		    $('#implementations').append(
						 '<li id="' 
						 + item.sha 
						 + '"><span>' 
						 + item.name 
						 + '</span></li>'
						 );

		     $('#' + item.sha + ' span').click(function() {
			     expand_language(item.sha);
			 });
		}
	    });
    }

    function process_master_sha_id(sha_id) {
	get_tree(sha_id, process_master_tree);
    }

    get_master_sha_id(process_master_sha_id);
}

function hide_language(id) {
    $('#' + id + ' ul').remove();
    $('#' + id + ' span').unbind('click');
    $('#' + id + ' span').click(function() {
	    expand_language(id);
	});
}

function expand_language(id) {
    $('#' + id).append('<ul></ul>');
    $('#' + id + ' span').unbind('click')
    $('#' + id + ' span').click(function () {
	    hide_language(id);
	})
    $('#' + id + ' ul').addClass('loading');
    $('#' + id + ' ul').html('<li>loading...</li>');

    function process_language_tree(treeitems) {
	$('#' + id + ' ul').removeClass('loading');
	$('#' + id + ' ul').html('');
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
	text = '<pre>' + blob.data + '</pre>';
	show_popup(blob.name, text);
    }
    
    get_blob(tree_sha, path, show_blob);
}

function show_popup(title, text) {

    $('#popup').fadeOut('fast');
    $('#popup h1').html(title);
    $('#popupText').html(text);

    var windowWidth = window.innerWidth; //document.documentElement.clientWidth;  
    var windowHeight = window.innerHeight; //document.documentElement.clientHeight;  
    var popupHeight = $('#popup').height();
    var popupWidth = $('#popup').width();

    debug('height' + popupHeight);
    
    $("#popup").css({
	    'position': 'absolute',
		'top': windowHeight/2-popupHeight/2 + $(window).scrollTop(),  
	    'left': windowWidth/2-popupWidth/2,
		});
    $('#popup').fadeIn('fast');
}

function close_popup() {
    $('#popup').fadeOut('fast');
}

function get_recent_commits(callback) {
    function get_from_branch(branch) {
	url = api_url + 'commits/list/' 
	    + username + '/' + reponame + '/' 
	    + branch + '?callback=?';
	$.getJSON(url, 
		  function(data) {
		      callback(data.commits);
		  }
		  );
    }
    
    get_master_sha_id(get_from_branch);
}
	
	    
function show_recent_commits() {

    $('#recent-commits').html('<div class="commit">loading...</div>');
    $('#recent-commits').addClass('loading');
	

    function show_commits(commits) {
	$('#recent-commits').html('');
	$('#recent-commits').removeClass('loading');
	$.each(commits.slice(0,3), function(i, item) {
		text = '<div class="commit">';
		text += '<span class="commit-message">';
		text += item.message;
		text += '</span>';
		text += ' by ';
		text += item.author.name;
		text += '</div>';

		$('#recent-commits').append(text)
		    });
	$(".commit-message").truncate( 30, {
		trail: [ " ( <a href='#' class='truncate_show'>more</a> . . . )", " ( . . . <a href='#' class='truncate_hide'>less</a> )" ]
		    });

    }
    get_recent_commits(show_commits)
}