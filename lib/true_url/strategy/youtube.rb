class TrueURL
	module Strategy
		class YouTube
			def find_canonical (context)
				path = context.working_url.path

				if context.working_url.host == "youtu.be"
					video_id = path[1..-1]
				
				elsif path == "/watch"
					video_id = context.working_url.query_values["v"]
				
				elsif path == "/playlist"
					playlist_id = context.working_url.query_values["list"]
				
				elsif path[0..17] == "/embed/videoseries"
					playlist_id = context.working_url.query_values["list"]

				elsif path[0..6] == "/embed/"
					video_id = path[7..-1]
					
				end

				unless video_id.nil?
					context.parse_new_url("https://www.youtube.com/watch?v=#{video_id}")
					context.finalize
				end

				unless playlist_id.nil?
					context.parse_new_url("https://www.youtube.com/playlist?list=#{playlist_id}")
					context.finalize
				end
			end
		end
	end
end