# constants loaded in rvmpow.rb

module Shared
	private
		# @return [Boolean]
		# 	true if config.ru exists
		def rakeApp?
			File.exists?(RvmPow::CONFIG_RU)
		end

		# return [Boolean]
		# 	true if the rvm binary exists
		def rvm?
			File.exists?(RvmPow::RVM_BINARY)
		end

		# return [Boolean]
		# 	true if Rack app and rvm binary exists
		def rakeAppAndRvm
			(rakeApp? && rvm?)
		end

		# Executes given proc if Rack app and rvm binary exists
		def exec_cmd
			if ! rakeAppAndRvm
				error "The current directory does not seem to be the root of a rake app or rvm is not installed. Nothing to do!"
				exit 0
			else
				yield
			end
		end
end