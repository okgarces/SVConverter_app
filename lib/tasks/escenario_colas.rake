task :escenario_colas => :environment do

for i in 0..20 do

	sleep 10
	@sqs = AWS::SQS.new
		@queue = @sqs.queues.create("dev_svconverterqueue")
		puts @queue.send_message("0;6d5edeeb-6a03-4139-ad72-400473637734;")  
end
end