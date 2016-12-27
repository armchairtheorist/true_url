class TrueURL
	module Strategy
		class Default
			def find_canonical (context)

				context.finalize
			end
		end
	end
end