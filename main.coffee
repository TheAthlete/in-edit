#
# InEdit main file
#
# Copyright (C) 2014 TheAthlete
#

# hook up dependencies
core    = require('core')
$       = require('dom')
Ajax    = require('ajax')
i18n    = require('i18n')
UI      = require('ui')

# local variables assignments
ext     = core.ext
bind    = core.bind
Class   = core.Class
Hash    = core.Hash
Element = $.Element
Form    = $.Form
Input   = $.Input
Spinner = UI.Spinner

# glue in your files
include 'src/in_edit'
include 'src/element'
include 'src/document'

# export your objects in the module
exports = ext InEdit,
  version: '%{version}'

# global exports (don't use unless you're really need that)
global.my_stuff = 'that pollutes the global scope'
