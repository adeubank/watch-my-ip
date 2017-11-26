require 'dotenv/load'
require 'open-uri'
require 'slack'

# BEGIN watch ip address

def save_ip(ip:)
	File.write(ENV['IPADDR_PATH'], ip)
end

def last_ip
	File.read(ENV['IPADDR_PATH']) if File.exists?(ENV['IPADDR_PATH'])
end

def latest_ip
	open('http://whatismyip.akamai.com').read
end

def alert(msg:)
	data = { text: msg }
	slack_post(data: data)
end

# END watch ip address

# BEGIN slack

def slack_configure
	Slack.configure do |config|
		config.token = ENV['SLACK_API_TOKEN']
	end
	@client = Slack::Web::Client.new
	@client.auth_test
end

def slack_post(data:)
	slack_configure
	@client.chat_postMessage(channel: '#alerts', text: data[:text], as_user: true)
end

# END slack
begin
	my_ip = latest_ip

	puts "Current IP Address: #{my_ip}"

	if last_ip && last_ip != my_ip
		alert(msg: "IP address changed, here is the new IP address: #{my_ip}")
	end

	save_ip(ip:my_ip)
rescue Exception => e
	slack_post(data: {text: "EXCEPTION: #{e.message}, ```#{e.backtrace.join("\n")}```"})
	raise
end
