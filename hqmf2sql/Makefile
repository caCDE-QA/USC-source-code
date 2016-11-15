all: compile

compile: parser

parser: lexer
	antlr4 -Dlanguage=Python3 -o build HQMFParser.g4
	antlr4 -Dlanguage=Python3 -o build HQMFv2JSONParser.g4
	antlr4 -Dlanguage=Python3 -o build HQMFv2XMLParser.g4

lexer:
	mkdir -p build
	antlr4 -Dlanguage=Python3 -o build HQMFLexer.g4
	antlr4 -Dlanguage=Python3 -o build HQMFv2JSONLexer.g4
	antlr4 -Dlanguage=Python3 -o build HQMFv2XMLLexer.g4



