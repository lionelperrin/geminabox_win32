GEMINABOX_DATA = File.join(File.absolute_path(File.dirname(__FILE__)), 'server')
LOG_FILE = File.join(GEMINABOX_DATA, 'geminabox.log')

require 'rubygems'
require 'geminabox'

begin
  require 'win32/daemon'

  class GeminaboxDaemon < Win32::Daemon
    def service_main
      Dir.mkdir GEMINABOX_DATA unless Dir.exists? GEMINABOX_DATA
      Geminabox.data = GEMINABOX_DATA
      Geminabox::Server.run!( bind: '0.0.0.0', port: 9090, server: 'webrick' )
      while running?
        File.open(LOG_FILE, "a"){ |f| f.puts "Service is running #{Time.now}" } 
        sleep 3600
      end
    end 

    def service_stop
      File.open(LOG_FILE, "a"){ |f| f.puts "***Service stopped #{Time.now}" }
      exit! 
    end
  end

  GeminaboxDaemon.mainloop
rescue Exception => err
  File.open(LOG_FILE,'a+'){ |f| f.puts " ***Daemon failure #{Time.now} err=#{err} " }
  raise
end
