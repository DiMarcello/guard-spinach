module Guard
  class Spinach
    class Runner
      attr_reader :paths, :options

      def initialize(paths, options = {})
        @paths = paths
        @options = options
      end

      def run
        message = "Running #{paths.empty? ? "all Spinach features" : paths.join(" ")}"
        UI.info message, :reset => true
        system(run_command)
      end

      def run_command
        "spinach #{(command_arguments + paths).join(" ")}"
      end

      protected

      def command_arguments
        [].tap do |args|
          args << options[:cli] if options[:cli]
        end
      end
    end
  end
end
