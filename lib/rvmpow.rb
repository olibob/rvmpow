require "rvmpow/version"
require "rvmpow/constants"
require 'tempfile'

module RvmPow

	class Pow

		# TODO: Check if things exist alredy (should not screw things up)
		# 			Correct removeFromFile method wich creates double entries

		def init
			# create .poenv in current dirrectory
			File.open(RvmPow::POW_ENV_FILE, "w") { |file| file.puts RvmPow::POWENV  }

			# link current app to ~/.pow directory
			File.symlink(RvmPow::RAKE_APP_DIRECTORY, RvmPow::POW_LINK)

			# create tmp/restart.txt file
			FileUtils.touch(RvmPow::RESTART_FILE)

			# add .powenv to .gitignore
			File.open(RvmPow::GITIGNORE_FILE, 'a') { |file| file.puts RvmPow::GITIGNORE_ENTRY }

			# add rvm ruby and gemset to Gemfile
			rvm = rvmInfo
			File.open(RvmPow::GEMFILE, 'a') { |file| file.puts "ruby '#{rvm[:ruby]}'\n#ruby-gemset=#{rvm[:gemset]}" }
			true
		rescue Exception => e
			puts e.message
			false
		end


		def clear
			FileUtils.rm_f [RvmPow::POW_ENV_FILE, RvmPow::RESTART_FILE, RvmPow::POW_LINK]

			gemfileMatchers = [/^ruby-\d(\.\d)+$/, /^#gemset=\S+$/]
			gitignoreMatchers = [/^#\srvmpow$/, /^\.powenv$/]
			removeFromFile(RvmPow::GITIGNORE_FILE, gitignoreMatchers)
			removeFromFile(RvmPow::GEMFILE, gemfileMatchers)

			true
		rescue Exception => e
			puts e.message
			false
		end

		private
			def removeFromFile(file, regexArray = [])
			# Open temporary file
			tmp = Tempfile.new("extract")

			# Write good lines to temporary file
			open(file, 'r').each do |l|
				regexArray.each { |regex| tmp << l unless l =~ regex } #wrong!!!
			end

			# Close tmp, or troubles ahead
			tmp.close

			# Move temp file to origin
			FileUtils.mv(tmp.path, '.gitignore')
			end

			def rvmInfo
				rvm = {}
				rvmArray = `rvm-prompt`.chomp.split('@')
				rvm[:ruby] = rvmArray[0].split('-')[1]
				rvm[:gemset] = rvmArray[1]
				rvm
			end
	end

end