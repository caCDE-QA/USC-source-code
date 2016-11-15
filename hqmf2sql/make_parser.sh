#!/usr/bin/env bash
# Note: need antlr4.5.1 or later to run this!
# see: http://www.antglr.org/download.html for details
antlr4 -Dlanguage=Python3  HQMFLexer.g4
antlr4 -Dlanguage=Python3  HQMFParser.g4
antlr4 -Dlanguage=Python3  HQMFv2Lexer.g4
antlr4 -Dlanguage=Python3  HQMFv2Parser.g4
antlr4 -Dlanguage=Python3  HQMFv2JSONLexer.g4
antlr4 -Dlanguage=Python3  HQMFv2JSONParser.g4
