require 'rubygems'
require 'win32/service'

include Win32

SERVICE_NAME = 'geminabox'
SERVICE_DISPLAYNAME = 'Geminabox'
cmd = "#{RbConfig.ruby} -C c:/temp #{File.join(File.absolute_path(File.dirname(__FILE__)), 'geminabox_winservice.rb')}"

# You must provide at least one argument.
raise ArgumentError, "No argument provided\nUsage: #{__FILE__} install/start/stop/uninstall/pause/resume" unless ARGV[0]

case ARGV[0].downcase
   when 'install'
      Service.new(
         :service_name     => SERVICE_NAME,
         :display_name     => SERVICE_DISPLAYNAME,
         :description      => 'Ruby gem server',
         :binary_path_name => cmd
      )
      puts 'Service ' + SERVICE_NAME + ' installed'
   when 'start'
      if Service.status(SERVICE_NAME).current_state != 'running'
         Service.start(SERVICE_NAME)
         while Service.status(SERVICE_NAME).current_state != 'running'
            puts 'One moment...' + Service.status(SERVICE_NAME).current_state
            sleep 1
         end
         puts 'Service ' + SERVICE_NAME + ' started'
      else
         puts 'Already running'
      end
   when 'stop'
      if Service.status(SERVICE_NAME).current_state != 'stopped'
         Service.stop(SERVICE_NAME)
         while Service.status(SERVICE_NAME).current_state != 'stopped'
            puts 'One moment...' + Service.status(SERVICE_NAME).current_state
            sleep 1
         end
         puts 'Service ' + SERVICE_NAME + ' stopped'
      else
         puts 'Already stopped'
      end
   when 'uninstall', 'delete'
      if Service.status(SERVICE_NAME).current_state != 'stopped'
         Service.stop(SERVICE_NAME)
      end
      while Service.status(SERVICE_NAME).current_state != 'stopped'
         puts 'One moment...' + Service.status(SERVICE_NAME).current_state
         sleep 1
      end
      Service.delete(SERVICE_NAME)
      puts 'Service ' + SERVICE_NAME + ' deleted'
   when 'pause'
      if Service.status(SERVICE_NAME).current_state != 'paused'
         Service.pause(SERVICE_NAME)
         while Service.status(SERVICE_NAME).current_state != 'paused'
            puts 'One moment...' + Service.status(SERVICE_NAME).current_state
            sleep 1
         end
         puts 'Service ' + SERVICE_NAME + ' paused'
      else
         puts 'Already paused'
      end
   when 'resume'
      if Service.status(SERVICE_NAME).current_state != 'running'
         Service.resume(SERVICE_NAME)
         while Service.status(SERVICE_NAME).current_state != 'running'
            puts 'One moment...' + Service.status(SERVICE_NAME).current_state
            sleep 1
         end
         puts 'Service ' + SERVICE_NAME + ' resumed'
      else
         puts 'Already running'
      end
   else
      raise ArgumentError, 'unknown option: ' + ARGV[0]
end

