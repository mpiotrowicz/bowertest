var JCDocs = (function($) {

	this.config = {};

	return {

		init: function() {

			JCDocs.pageAnchorNavigation.init();

      // get those syntaxes highlighted
      prettyPrint();

		}

	}

}(jQuery));

/*
 * Build page navigation based on the page contents
 */ 
JCDocs.pageAnchorNavigation = (function($, p) {
  var config = {
  	  $navContainer: $('#Sidebar'),
  	  $navList: $('<ul>').appendTo('#Sidebar')
  };
  var $win = $(window),
      $nav = $('#Sidebar'),
      navTop = 30,
      $mainContent = $('.main > .content');
  p.status = {
    isFixed: 0
  }

  p.init = function(){
    
  	this.buildNav();

    this.processScroll();
    $win.on('scroll', this.processScroll);

	}

  p.buildNav = function() {
    $('#DocumentContentContainer > section').each( function() {
      var $section = $(this),
          $sectionHeading = $section.find('h1:eq(0)'),
          sectionTitle = JCDocs.utils.htmlDecode( $sectionHeading.html() ),
          sectionId = $sectionHeading.attr('id'),
          $newItem = $('<li>');

      $('<a/>', {href: '#'+sectionId, text: sectionTitle} ).appendTo( $newItem );

      if( $articles = $( $section.find('> article') ) ) {
        var $articleList = $('<ul>');
        $articles.each( function() {
          var $article = $(this),
              $articleHeading = $article.find('h1:eq(0)'),
              articleTitle = JCDocs.utils.htmlDecode( $articleHeading.html() ),
              articleId = $articleHeading.attr('id'),
              $newItem = $('<li>');

          $('<a/>', {href: '#'+articleId, text: articleTitle}).appendTo( $newItem );
          $articleList.append( $newItem );
        });
        $newItem.append( $articleList );
      }
      config.$navList.append($newItem);

      config.$navContainer.removeClass('loading');
    });
  }

  p.processScroll = function() {
    var i, scrollTop = $win.scrollTop();
    if (scrollTop >= navTop && !this.isFixed) {
      this.isFixed = 1
      $nav.addClass('fixed');
    } else if (scrollTop <= navTop && this.isFixed) {
      this.isFixed = 0
      $nav.removeClass('fixed');
    }
    console.log(this.isFixed);
  }

  return p;
}( jQuery, JCDocs.pageAnchorNavigation || {} ));


JCDocs.utils = (function($, p) {

  /*
   * Check if object is an array
   *
   * @param (Object) The object to check
   * @return (Boolean) The result of the test
   */ 
	p.htmlDecode = function(input){
	  var e = document.createElement('div');
	  e.innerHTML = input;
	  return e.childNodes.length === 0 ? "" : e.childNodes[0].nodeValue;
	}

	return p;
}( jQuery, JCDocs.utils || {} ))


/*
 * Go go gadget JavaScript
 */
jQuery(document).ready(function() {
  JCDocs.init();
});