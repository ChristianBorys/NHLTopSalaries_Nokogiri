# encoding: utf-8
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://capgeek.com/leaders/?type=SALARY"))
players = page.css('tbody tr') 


File.open('NHL_salaries.html', 'w') do |f|

	f.puts("<html>")
	f.puts("<head>")
	f.puts("<link rel=\"stylesheet\" type=\"text/css\" href=\"worldnews.css\">")
	f.puts("<link href='http://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css'>")
	f.puts("<title>NHL's Top Salaries</title>")
	f.puts("</head>")
	f.puts("<body>")
	f.puts("<ul>")

	size = 600

	players.each_with_index do |player, i|
		name = player.css('a').inner_text.gsub("»", "")
		salary = player.css('td:last-child').inner_text
		f.puts("<li style='width:#{size}px;height:#{size}px;'> <div> <div>#{name}</div> <div> #{salary} </div> </div> </li>")		
		size = size - (size * ((players.length - i).to_f / 200))
	end

	f.puts("</ul>")	
	f.puts("</div>")
	f.puts("</body>\n")	
	f.puts("</html>\n")	
end

