# constants loaded in rvmpow.rb

module RvmPow
	private

		def rakeApp?
			File.exists?(RvmPow::CONFIG_RU)
		end

		def rvm?
			File.exists?(RvmPow::RVM_BINARY)
		end

		def rakeAppAndRvm
			(rakeApp? && rvm?)
		end

		def exec_cmd
			if ! rakeAppAndRvm
				error "The current directory does not seem to be the root of a rake app or rvm is not installed. Nothing to do!"
				exit 0
			else
				yield
			end
		end
end