class TrueURL
  module Strategy
    class Twitter
      def execute(context)
        fragment = context.working_url.fragment

        # Special handling to collapse Twitter hashbang (#!) URLs
        unless fragment.nil?
          if fragment.start_with?('!/')
            context.working_url.path = fragment[1..-1]
            context.working_url.fragment = nil
          end
        end

        path = context.working_url.path

        if path =~ /^\/\w+\/status\/\d+/
          parts = path.split('/')
          context.set_working_url("https://twitter.com/#{parts[1].downcase}/status/#{parts[3]}")
          context.finalize
        end
      end
    end
  end
end
