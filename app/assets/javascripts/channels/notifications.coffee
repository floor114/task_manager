App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    switch data['action']
      when 'share'
        if $('.tasks-empty').length > 0
          $('.tasks-empty').remove()
        $('#tasks-table').append $(data['partial']).fadeIn()
      when 'update'
        $("#task-#{data['task_id']}").html(data['partial'])
      when 'destroy'
        $("#task-#{data['task_id']}").fadeOut ->
          $(this).remove()
          $("#tasks-table").html(data['partial'])
