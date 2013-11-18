task :escenario_web => :environment do

require 'open-uri'

for i in 0..1000 do

	puts Thread.new{funcionWeb()}
	
end
end

def funcionWeb()

	for i in 0..100000 do
	contents = open('http://svconverterlbweb-621802330.us-east-1.elb.amazonaws.com:3000/') {|io| io.read}
	puts contents
	end
end