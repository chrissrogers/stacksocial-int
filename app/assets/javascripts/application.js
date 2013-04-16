$(function () {

  _.templateSettings = {
    interpolate: /\{\{(.+?)\}\}/g,
    evaluate: /\{\{\$(.+?)\$\}\}/g,
  };

  var userDetailTarget = $('#user-display-target'),
      loadingTemplate  = Handlebars.compile($('#loading-tpl').html()),
      userTemplate     = Handlebars.compile($('#user-tpl').html());

  $('a[data-detail-id]').on('click', function (event) {

    event.preventDefault();

    var anchor = $(this),
        userId = anchor.data('detail-id'),
        user   = _.find(window.App.users, function (user) { return user.screen_name === userId; });

    userDetailTarget
      .html(loadingTemplate)
      .css({
        position: 'relative',
        top:       anchor.position().top
      });

    $.ajax('/api/user/' + userId)
      .success(function (tweets) {
        userDetailTarget.html(userTemplate({
          user:   user,
          tweets: tweets
        }));
      })
      .error(function () { userDetailTarget.html('Oops! We had a problem. Please try again.'); });

    return false;

  });

});
