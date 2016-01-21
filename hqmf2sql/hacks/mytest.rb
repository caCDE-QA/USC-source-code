require 'health-data-standards'
require 'hqmf-parser'
require 'json'

include HQMF2

d=HQMF2::Document.new($stdin.read())
$stdout.write(JSON.pretty_generate(d.to_model().to_json()))
