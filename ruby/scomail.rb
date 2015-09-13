#!/usr/bin/ruby
require 'net/smtp'
require 'time'

filename = "graph.html"
file = File.open("result.txt", "rb")
fileContent = file.read


# Read a file and encode it into base64 format
#graph_filecontent = File.read(filename)
#encoded_graph = [graph_filecontent].pack("m")   # base64

marker = "AUNIQUEMARKER"



signature =<<EOF
<table>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td>Regards,</td></tr>
    <tr><td>Athena Support</td></tr>
    <tr><td><i>This is an auto-generated email, please do not respond to this email</i></td></tr>
</table>
<br>
EOF

# Define the main headers.
message_header =<<EOF
From: machine1@scoday.com 
To: sday@mac.com
Subject: CalEnergy Monitoring Alert
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=#{marker}

--#{marker}
EOF

# Define the message action
part2 =<<EOF
Content-Type: text/html
Content-Transfer-Encoding:8bit

#{fileContent}
<br>
--#{marker}
EOF


# Define the message action
part3 =<<EOF
Content-Type: text/html
Content-Transfer-Encoding:8bit

#{signature}
--#{marker}
EOF


message = message_header + part2 + part3



Net::SMTP.start('relay.apple.com') do |smtp|
  #smtp.send_message message, 'aml-monitor-alert@group.apple.com','Athena_Support@group.apple.com'
  smtp.send_message message, 'machine1@scoday.com',['machine1@scoday.com','sday@mac.com']
end