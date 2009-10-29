$(document).ready( 
  function () { 
    // comment placeholder texts
    placeholder("#comment_submitter_name",  "Name");
    placeholder("#comment_submitter_email", "email@address");
    placeholder("#comment_submitter_url",   "http://my.url");
    placeholder("#comment_body",            "Have your say.");

    placeholder("#image_description", "Description");
    placeholder("#image_source_url",  "http://...");

    toggle("#comment_help_toggle_link",     ".help");
    toggle("#extended_toggle_link",     ".extended");
  } 
);

function toggle(link, target) {
  $(link).click(
    function (e) {
      $(target).slideToggle();
      return false;
    }
  )
}

function placeholder(sel, txt) {
  $(sel).each(
    function (i) {
      if (! $(this).val()) { $(this).val(txt); }

      $(this).blur(
        function () {
          if ($(this).val() == '') { $(this).val(txt); }
        }
      )
      $(this).focus(
        function () {
          if ($(this).val() == txt) { $(this).val(''); }
        }
      )
    }
  );

  $('form').filter(':has('+ sel +')').submit(
    function () {
      $(sel).each(
        function (i) {
          if ($(this).val() == txt) {
            $(this).val('');
          }
        }
      )
    }
  )
}


