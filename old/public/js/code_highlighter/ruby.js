CodeHighlighter.addStyle("ruby",{
  comment : {
    exp  : /#[^\n]+/
  },
  brackets : {
    exp  : /\(|\)/
  },
  constant : {
    exp  : /\b[A-Z][a-zA-Z]*\b/
  },
  string : {
    exp  : /'[^']*'|"[^"]*"/
  },
  keywords : {
    exp  : /\b(do|end|self|class|def|if|module|yield|then|else|for|until|unless|while|elsif|case|when|break|retry|redo|rescue|require|raise)\b/
  },
  /* Added by Shelly Fisher (shelly@agileevolved.com) */
  symbol : {
    exp : /(:[a-z0-9_!?]+)/
  },
  instance_variable : {
    exp : /@([A-Za-z0-9_!?]+)/
  }
});
