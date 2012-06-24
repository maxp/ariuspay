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


# newpay

$ ->
  $("#frm_newpay").submit ->
    console.log serialize_form( $(this) )

    post_json( 'newpay',
      serialize_form($(this)),
      (data) ->
        console.log 'reseived', data
      (xhr) ->
        console.error 'ajax error'
    )
    false
#--

# document focus setup
$ ->
   $("input[type=text]:first").focus()

#.