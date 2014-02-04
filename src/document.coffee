#
# The document hooks for in-edit form
#
# Copyright (C) 2014 TheAthlete
#
$(document).on
  keydown: (event)->
    InEdit.current.hide() if event.keyCode is 27 and InEdit.current

#$(document).delegate 'a[data-in-edit]', 'click', (event) ->
  #event.preventDefault()
  #new InEdit(this, options).show()
