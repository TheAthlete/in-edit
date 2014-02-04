#
# The element level inline editor extension
#
# Copyright (C) 2014 TheAthlete
#
Element.include

  #
  # Triggers an inline-editor feature on the element
  #
  # @param Object options for the InEdit class
  # @return InEdit object
  #
  inEdit: (options) ->
    new InEdit(this, options).show()
