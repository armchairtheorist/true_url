class TrueURL
  module Strategy
    class Vimeo
      def find_canonical(context)
        path = context.working_url.path

        if context.working_url.host == 'player.vimeo.com'
          video_id = path[7..-1]

        elsif path.match(/^\/channels\/\w+\/\d+$/)
          video_id = path.split('/').last
        
        elsif path.match(/^\/\d+$/)
          video_id = path[1..-1]
        end

        if video_id
          context.set_working_url("https://vimeo.com/#{video_id}")
          context.finalize
          context.attributes[:embed_url] = "https://player.vimeo.com/video/#{video_id}"
        end

        # Vimeo supports both HTTP and HTTPS and doesn't redirect between them, so we prefer HTTPS
        context.working_url.scheme = "https"
      end
    end
  end
end
