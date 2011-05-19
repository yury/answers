require 'spec_helper'
require 'grabber'
require 'tempfile'

describe Grabber do
  before :all do
    @google_dir = File.join Dir.tmpdir, 'google'
    @yandex_dir = File.join Dir.tmpdir, 'yandex'
  end
  
  after :all do
    FileUtils.rm_f([@google_dir, @yandex_dir])
  end
  
  def check_image_files files
    files.length.should > 0
    files.each do |f|
      File.exist?(f).should be_true
      File.new(f).size.should > 0
      f.should match("png|gif|jpg$")
    end
  end
  
  context "Work in real world", :network => true, :speed => :slow do
    it "should grab images from google" do
      files = subject.grab_images_from("http://www.google.com", :to => @google_dir)
      check_image_files files
    end
    
    it "should grab images from yandex" do
      files = subject.grab_images_from("http://yandex.ru", :to => @yandex_dir)
      check_image_files files
    end
  end
end