require "erb"

desc "Generate WASM HTML"
task :generate_html do
  name = "pokemon.html"
  html = ERB.new(
    File.read("#{name}.erb"),
    trim_mode: "%>"
  ).result
  File.write(name, html)
end

task default: [:generate_html]
