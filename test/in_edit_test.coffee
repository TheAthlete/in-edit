#
# Project's main unit test
#
# Copyright (C) 2014 TheAthlete
#
{Test, assert} = require('lovely')

describe "InEdit", ->
  InEdit = window = document = $ = null

  before Test.load (build, win)->
    InEdit = build
    window   = win
    document = win.document
    $        = win.Lovely.module('dom')

  it "should have a version", ->
    assert.ok InEdit.version

