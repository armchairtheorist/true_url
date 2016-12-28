class TrueURL
  module Strategy
    class Vimeo
      def find_canonical(context)
        # path = context.working_url.path

        # if context.working_url.host == 'player.vimeo.com'
        #   video_id = path[7..-1]

        # elsif path[0..8] == '/channels/'
        #   video_id = path.split('/').last

        # if video_id
        #   context.set_working_url("https://vimeo.com/#{video_id}")
        # end
        #   query_values = context.working_url.query_values
          
        #   context.set_working_url

        # if 
        #   context.attributes[:vimeo_embed] = "https://www.dailymotion.com/embed/video/#{video_id}"
        # end

        # context.finalize
      end
    end
  end
end
