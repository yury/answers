require 'fileutils'
require 'mechanize'

class Grabber
  
  # get only images from IMG html tags. 
  # do not detect image urls in css and javascript
  def grab_images_from url, options = {}
    dest_dir = options[:to] || "/tmp"
    threads_count = options[:threads_count] || 10
    threads_count = 1 if threads_count.to_i <= 0
    
    FileUtils.mkpath dest_dir
    files = []
    
    agent = Mechanize.new
    page = agent.get(url)
    urls = page.image_urls
    
    # yandex use image urls without extensions
    urls.select! {|u| u =~ /png|gif|jpg|jpeg|bmp|tif|tiff$/i}
    
    urls_lock = Mutex.new
    files_lock = Mutex.new
    threads = threads_count.times.map do
      Thread.new do
        loop do
          file = urls_lock.synchronize { urls.pop }
          break if file.nil?
          dest_file = download file, dest_dir
          files_lock.synchronize {files.push(dest_file)}
        end
      end
    end
    threads.each {|t| t.join}
    files
  end
    
  def download resource, dest_dir
    agent = Mechanize.new
    file = agent.get(resource)
    path = "#{dest_dir}/#{file.filename}"
    file.save_as(path)
    path
  end  
end