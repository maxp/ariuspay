#
#   ariuspay ui.coffee
#

serialize_form = ($form) ->
  res = {}
  for f in $form.serializeArray()
    k = f['name']
    if res[k]?
      unless res[k].push
        res[k] = [res[k]]
      res[k].push f['value']
    else
      res[k] = f['value']
  #
  res
#-

post_json = (url, obj, success, error) ->
  if typeof obj isnt "string"
    obj = obj? and JSON.stringify(obj) or "{}"
  $.ajax
    # timeout: 5000
    type: 'POST'
    contentType: 'application/json'
    url: url
    data: obj
    dataType: 'json'
    success: (data) -> success data
    error: (xhr) -> error(xhr) if error
  # returns xhr, could be used for error handling but check for possible races!
#--


# new_order

$ ->
  $("#frm_order").submit ->
    console.log serialize_form( $(this) )

    post_json(
      'new_order',
      serialize_form($(this)),
      (data) ->
        console.log 'recieved:', data
        if data.err
          console.log "data_err:", data.err
          alert "data err: "+data.err
        else
          window.location.href = data.redir

      (xhr) ->
        console.error 'ajax error'
        alert "ajax error"
    )
    false
#--


# bill

$ ->
  $("#frm_bill").submit ->
    post_json(
      window.location.href,
      serialize_form($(this)),
      (data) ->
        console.log 'bill_redir:', data
        if data.err
          console.log "data_err:", data.err
          alert "data err: "+data.err
        else
          window.location.href = data.redir

      (xhr) ->
        console.error 'ajax error'
        alert "ajax error"
    )
    false
#--

# document focus setup
$ ->
   $("input[type=text]:first").focus()

#.