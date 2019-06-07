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

def photos_count(data)
  camera = []
  data['photos'].each do |photo|
    camera.push photo['camera']['name']
  end

  chemcam = camera.count('CHEMCAM')
  mahli = camera.count('MAHLI')
  navcam = camera.count('NAVCAM')

  hash = ['CHEMCAM', 'MAHLI', 'NAVCAM']

  num_array = [chemcam, mahli, navcam]

  final_hash = hash.zip(num_array).to_h

  print final_hash, "\n"
end

photos_count(data)
