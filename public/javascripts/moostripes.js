/* 
Script: mooStripes.js for mootools v1.1
	by Floor SA (http://www.floor.ch) - MIT-style license
*/

/**
Class: mooStripes
	Add stripes to the table passed in parameters
	
Example:

	In the <head> of the html file
	
		<link media="screen" rel="stylesheet" href="css/moostripes.css" type="text/css"/>
		<script src="js/mootools.js" type="text/javascript"></script>
		<script src="js/mooStripes.js" type="text/javascript"></script>

		<script type="text/javascript">
		window.addEvent("domready", function() {
			new mooStripes('idOfTheTable', {oddClass:'odd', evenClass:'even'});
		});
		</script>
*/

var mooStripes = new Class({

	/**
	Property: options
	
	Options:
		oddClass		- Class to apply for odd lines
		evenClass		- Class to apply for even lines
	*/
	
	options: {
		oddClass			: 'odd',
		ovenClass			: 'even'
	},
	
	/**
	Property: initialize
		Set the options and start the ajaxRequest
	*/
	
	initialize: function(container, options) {
		this.setOptions(options);
		this.applyStripes(container);
	},

	/*
	Property: tablePrep
		Prepare the table

	Arguments:
		co 	- ID of the result container
	*/
	
	applyStripes: function(co){
		// Apply stripes
		$ES('tr', $(co)).each(function(el, n){
			if (n % 2 == 0){
				el.addClass(this.options.ovenClass); 
			} else {
				el.addClass(this.options.oddClass); 
			}
		}.bind(this));
	}
});

mooStripes.implement(new Options);// Implements setOptions(defaults, options)