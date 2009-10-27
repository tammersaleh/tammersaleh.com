function toggle_contents(node, content_class) {
  var contents = node.find(content_class);
  if (contents.is(":visible")) {
    node.addClass("closed");
    node.removeClass("opened");
    contents.slideUp();
  } else {
    node.removeClass("closed");
    node.addClass("opened");
    contents.slideDown();
  }
};

function hide_or_show_notes_by_company(checkbox_node) {
  var checkbox = $(checkbox_node);
  var company_name = $.trim(checkbox.val());
  $(".note").each(function() {
    if ($.trim($(this).children(".company_name").text()) == company_name) { 
      if (checkbox.is(":checked")) {
        $(this).fadeIn("normal", function() {$(this).show()}); 
      } else {
        $(this).fadeOut("normal", function() {$(this).hide()}); 
      };
    };
  });
};

function open_external_links_in_new_window() {
  $(".external").attr("target", "_blank");
}

$(document).ready(function() {
  $('#participating_company_filters input').change(function() { 
    hide_or_show_notes_by_company(this);
  });

  $('.pages-show .notes .note').each(function() { 
    var note = $(this);
    $(note).find('.contents').hide();
    $(note).find('.note_type').hide();
    note.find('.title').click(function(event) { 
      toggle_contents(note, ".contents"); 
      toggle_contents(note, ".note_type")
      event.preventDefault();
    });
    note.find('.note_type').click(function(event) { 
      toggle_contents(note, ".contents"); 
      toggle_contents(note, ".note_type")
      event.preventDefault();
    });
  });
  
  $('.pages-show #filter_notes').each(function() { 
    var filter = $(this);
    $(filter).find('.companies').hide();
    filter.find('.title').click(function(event) { 
      toggle_contents(filter, ".companies"); 
      event.preventDefault();
    });
  });

  $('.user').each(function() { 
    var owner = $(this);
    owner.find('.name').click(function(event) { 
      toggle_contents(owner, ".owner_contents"); 
      event.preventDefault();
    });
    $(owner).find('.owner_contents').hide();
  });

  open_external_links_in_new_window();
});

