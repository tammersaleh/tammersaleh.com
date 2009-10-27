(function(){
  this.__defineGetter__("exit", function(){ java.lang.System.exit(0) });
  this.__defineGetter__("quit", function(){ java.lang.System.exit(0) });
  
  print("=================================================");
  print(" Rhino JavaScript Shell");
  print(" To exit type 'exit', 'quit', or 'quit()'.");
  print("=================================================");

  var plugin_prefix = environment["blue.ridge.prefix"] || "vendor/plugins/blue-ridge";
  var fixture_file = plugin_prefix + "/generators/blue_ridge/templates/application.html";

  load(plugin_prefix + "/vendor/env.rhino.js");
  print(" - loaded env.js");

  window.location = fixture_file;
  print(" - sample DOM loaded");

  load(plugin_prefix + "/vendor/jquery-1.3.2.js");
  print(" - jQuery-1.3.2 loaded");
  
  load(plugin_prefix + "/vendor/jquery.print.js");
  print(" - jQuery print lib loaded");

  print("=================================================");
})();
