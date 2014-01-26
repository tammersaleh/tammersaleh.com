// Loads all Bootstrap javascripts
//  require bootstrap
// ...or...
//  require bootstrap-affix.js
//  require bootstrap-alert.js
//  require bootstrap-button.js
//  require bootstrap-carousel.js
//  require bootstrap-collapse.js
//  require bootstrap-dropdown.js
//  require bootstrap-modal.js
//  require bootstrap-popover.js
//  require bootstrap-scrollspy.js
//  require bootstrap-tab.js
//  require bootstrap-tooltip.js
//  require bootstrap-transition.js
//  require bootstrap-typeahead.js
//
//= require libs/jquery.lazyload.min.js
//= require libs/bigtext.js

(function() {
  var config = {
    kitId: 'ilx3ybb',
    scriptTimeout: 3000,
    active: function () {
      $('#tammersaleh').bigtext();
      $('#about_me .skills').bigtext();
    }
  };
  var h=document.getElementsByTagName("html")[0];h.className+=" wf-loading";var t=setTimeout(function(){h.className=h.className.replace(/(\s|^)wf-loading(\s|$)/g," ");h.className+=" wf-inactive"},config.scriptTimeout);var tk=document.createElement("script"),d=false;tk.src='//use.typekit.net/'+config.kitId+'.js';tk.type="text/javascript";tk.async="true";tk.onload=tk.onreadystatechange=function(){var a=this.readyState;if(d||a&&a!="complete"&&a!="loaded")return;d=true;clearTimeout(t);try{Typekit.load(config)}catch(b){}};var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(tk,s)
})();

$(function() {
  $(".background").lazyload({
    effect: "fadeIn",
    effectspeed: 900
  });

  $.get("/recommendations.json", function(recommendations) {
    entry = recommendations[Math.floor(Math.random() * recommendations.length)]
    $("#kind_words .quote").html( entry.quote );
    $("#kind_words cite"  ).html( "&mdash; " + entry.who );
  });
});
