require 'Faker'

str = ""

# anything_inside("**") #=> /\*\*.*\*\*/
def anything_inside(start, ending=nil)

    start = "\\" + start.chars.join("\\")
    ending = start if ending == nil
    Regexp.new(start + ".*" + ending)

end

  
def markdown_to_html(text)

    text
      .gsub(anything_inside(">", "\n\n"))  {|txt| "<q>#{txt.sub(/^>*/,"").tr("\n\n", "")}</q>" }
      .gsub(anything_inside("**")) {|txt| "<b>#{txt.tr("**","")}</b>"}
      .gsub(anything_inside("_")) {|txt| "<i>#{txt.tr("_","")}</i>"}
      .gsub(anything_inside("`"))  {|txt| "<code>#{txt.tr("`","")}</code>"}
      .gsub(anything_inside("#####", "\n")) {|txt| "<h5>#{txt.tr("\n","").sub(/^\#*/,"")}</h5>"}
      .gsub(anything_inside("####", "\n")) {|txt| "<h4>#{txt.tr("\n","").sub(/^\#*/,"")}</h4>"}
      .gsub(anything_inside("###", "\n")) {|txt| "<h3>#{txt.tr("\n","").sub(/^\#*/,"")}</h3>"}
      .gsub(anything_inside("##", "\n")) {|txt| "<h2>#{txt.tr("\n","").sub(/^\#*/,"")}</h2>"}
      .gsub(anything_inside("#", "\n")) {|txt| "<h1>#{txt.tr("\n","").sub(/^\#*/,"")}</h1>"}
      .gsub(anything_inside("\n")) {|txt| "\n<p>#{txt.tr("\n","")}</p>\n"}
      .gsub(/\ \ \ \ .*/) {|txt| "<code>#{txt.strip}</code>"}
     
end
  

def create_file
  
  File.open("markdown.txt","w") do |text|

     text << Faker::Markdown.sandwich(sentences: 6)
     
  end
  
end


def file_to_string(str)

  file =  File.read("markdown.txt")
  str << file
  puts str

end 



create_file
file_to_string(str)
File.write("example.html", markdown_to_html(str))
