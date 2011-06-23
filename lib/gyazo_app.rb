require 'gyazo/initialize'
require 'gyazo/image'

class GyazoApp < Sinatra::Base
  set :gyazo_id, false
  #set :my_host, "gyazo.udzura.jp"
  set :repository_url, 'https://github.com/udzura/upload.cgi'
  
  before do
    if !request.get? && options.gyazo_id
      halt(500) unless params[:id] == options.gyazo_id
    end
  end

  get '/' do
    redirect options.repository_url
  end
  
  get '/favicon.ico' do
    send_file File.expand_path("../../favicon.ico", __FILE__),
              :type => 'image/x-icon', :disposition => 'inline' \
        rescue raise(Sinatra::NotFound)
  end

  post '/upload.cgi' do
    data = (begin
              params[:imagedata][:tempfile].read
            rescue
              params[:imagedata]
            end)
    hash = Digest::MD5.hexdigest(data).to_s
    @image = Gyazo::Image.create!(:gyazo_hash => hash, :body => BSON::Binary.new(data))
    "http://#{options.my_host rescue request.host_with_port}/#{@image.gyazo_hash}.png"
  end

  get '/:id.png' do
    @image = Gyazo::Image.where(:gyazo_hash => params[:id]).first \
        or raise(Sinatra::NotFound)
    content_type 'image/png'
    @image.body.to_s
  end

  delete '/:id.png' do
    content_type 'text/plain'
    @image = Gyazo::Image.where(:gyazo_hash => params[:id]).first
    @image.destroy ? "Destroy Success!" : halt(503)
  end
end
