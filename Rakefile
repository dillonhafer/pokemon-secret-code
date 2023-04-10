require "erb"

desc "Generate WASM HTML"
task :generate_html do
  html = ERB.new(
    File.read("pokemon.html.erb"),
    trim_mode: "%>"
  ).result
  File.write("index.html", html)
end

task default: [:generate_html]
