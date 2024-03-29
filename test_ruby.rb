require 'uri'
require 'net/http'
require 'json'
require 'pp'
def request(url, api_key = "K6j0PyEOPtrGodgBdrx5qr6Detq9L7d7Ffoi02pQ")
  url = URI("#{url}&api_key=#{api_key}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(url)
  request["cache-control"] = 'no-cache'
  request["Postman-Token"] = '2178e596-b98d-4395-bfa7-e0ac0e2df059'
  response = http.request(request)
  JSON.parse(response.read_body)
end

data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")

def build_web_page(data)
html = ""

data['photos'].each do |photo|
  html += "<li><img src=\"#{photo['img_src']}\"></li>\n"
end

File.write('index.html', "<!DOCTYPE html>
<html lang=\"en\">
<head>
  <meta charset=\"UTF-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
  <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">
  <title>Document</title>
</head>
<body>
  <ul>
    #{html}
  </ul>
</body>
</html>")
end
