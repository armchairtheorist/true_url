class TrueURL
  module Strategy
    class DailyMotion
      def find_canonical(context)
        path = context.working_url.path

        if context.working_url.host == 'dai.ly'
          video_id = path[1..-1]

        elsif path[0..6] == '/video/'
          video_id = clean_video_id(path)

        elsif path[0..6] == '/embed/'
          video_id = path[13..-1]
        
        elsif path[0..9] == '/playlist/'
          playlist_id = clean_playlist_id(path)
        end

        unless video_id.nil?
          context.set_working_url("https://www.dailymotion.com/video/#{video_id}")
          context.finalize
          context.attributes[:dailymotion_embed] = "https://www.dailymotion.com/embed/video/#{video_id}"
        end

        unless playlist_id.nil?
          context.set_working_url("https://www.dailymotion.com/playlist/#{playlist_id}")
          context.finalize
        end
      end

      def clean_video_id (path)
        if path.index('_')
          path[7..path.index('_') - 1]
        else
          path[7..-1]
        end
      end

      def clean_playlist_id (path)
        cpath = path[10..-1]

        if cpath.index('_')
          cpath[0..cpath.index('_') - 1]
        elsif cpath.index('/') 
          cpath[0..cpath.index('/') - 1]
        else
          cpath[0..-1]
        end
      end
    end
  end
end
