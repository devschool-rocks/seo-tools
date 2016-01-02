// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require_tree .

function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + (exdays*24*60*60*1000));
  var expires = "expires="+d.toUTCString();
  document.cookie = cname + "=" + cvalue + "; " + expires;
}

function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i=0; i<ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0)==' ') c = c.substring(1);
    if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
  }
  return "";
}

$(document).ready(function () {
  $('a[href="/' + window.location.pathname.split("/")[1] + '"]').parent().addClass('active');

  var activeDomain = getCookie("my-domain");
  var selectBrand = function(domain) {
    setCookie("my-domain", domain, 365);
    $(".table-serps tbody tr").each(function() {
      td = $($(this).find("td")[0]);
      td.removeClass("brand").removeClass("competitor");
      if (td.parent().data("domain") == domain) {
        td.addClass("brand");
      } else {
        td.addClass("competitor");
      }
    });
  }

  if (activeDomain != null) {
    $('.select-my-domain').filter(function() {
      return $(this).data("value") == activeDomain 
    }).prop('checked', true);
    var domain = $('.select-my-domain').filter(':checked').data("value")
    selectBrand(domain);
  }

  $('.select-my-domain').on("change", function() {
    selectBrand($(this).data("value"));
  });
});
