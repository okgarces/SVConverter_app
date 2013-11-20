task :escenario_web => :environment do

require 'open-uri'

for i in 0..10 do

	Thread.new{funcionWeb()}
	
end
end

def funcionWeb()

	for i in 0..1000 do
	puts contents = open('http://svconverter.herokuapp.com') {|io| io.read}
	end
end