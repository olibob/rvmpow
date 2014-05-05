require "rvmpow/version"
require "rvmpow/constants"
require 'tempfile'
require 'fileutils'

module RvmPow

	class Pow
		# create .poenv in current dirrectory
		def createPowenvFile
			action = -> do
				File.open(RvmPow::POW_ENV_FILE, "w+") { |file| file.puts RvmPow::POWENV  }
			end
			fileAction action
		end

		# link current app to ~/.pow directory
		def createPowLink
			action = -> { File.symlink(RvmPow::RAKE_APP_DIRECTORY, RvmPow::POW_LINK) }
			fileAction action
		end

		# create tmp/restart.txt file
		def touchRestartFile
			action = -> do
				createTmpDirIfNeeded
				FileUtils.touch(RvmPow::RESTART_FILE)
			end
			fileAction action
		end

		# create tmp/always_restart.txt file
		def touchAlwaysRestartFile
			action = -> do
				createTmpDirIfNeeded
				FileUtils.touch(RvmPow::ALWAYS_RESTART_FILE)
			end
			fileAction action
		end

		# add .powenv to .gitignore
		def gitignorePowenv
			action = -> do
				File.open(RvmPow::GITIGNORE_FILE, 'a') { |file| file.puts RvmPow::GITIGNORE_ENTRY }
			end
			fileAction action
		end

		# add rvm ruby and gemset to Gemfile
		def addRvmInfoToGemfile
			action = -> do
				rvm = rvmInfo
				File.open(RvmPow::GEMFILE, 'a+') do |file|
					s = file.read
					if (s.match(/ruby\s'\d(\.\d)+'/) || s.match(/ruby-gemset=/))
						puts "\truby or gemset information already present in Gemfile"
					else
						file.puts "\n# rvmpow\nruby '#{rvm[:ruby]}'\n#ruby-gemset=#{rvm[:gemset]}"
					end
				end
			end
			fileAction action
		end

		# removes rvmpow entries from .gitignore
		def restoreGitignore
			action = -> { removeFromFile(RvmPow::GITIGNORE_FILE, RvmPow::GITIGNORE_MATCHER) }
			fileAction action
		end

		# removes rvmpow entries from Gemfile
		def restoreGemfile
			action = -> do
				File.open(RvmPow::GEMFILE, 'r') do |file|
					s = file.read
					if !(s.match(/^#\srvmpow$/))
						puts "\tNo rvmpow entry found, continuing ..."
					else
						removeFromFile(RvmPow::GEMFILE, RvmPow::GEMFILE_MATCHER)
					end
				end
			end
			fileAction action
		end

		# removes .powenv
		def deletePowenvFile
			action = -> { FileUtils.rm_f RvmPow::POW_ENV_FILE }
			fileAction action
		end

		# removes restart.txt file from ./tmp/
		def deleteRestartFile
			action = -> { FileUtils.rm_f RvmPow::RESTART_FILE }
			fileAction action
		end

		# removes always_restart.txt file from ./tmp/
		def deleteAlwaysRestartFile
			action = -> { FileUtils.rm_f RvmPow::ALWAYS_RESTART_FILE }
			fileAction action
		end

		# deletes the link is ~/.pow
		def deletePowLink
			action = -> { FileUtils.rm_f RvmPow::POW_LINK }
			fileAction action
		end

		private

			# file action wrapper
			def fileAction(action)
				action.call
				true
			rescue Exception => err
				puts err.message
				false
			end

			# removes text from file based on regex
			def removeFromFile(file, regex)
				# create tempfile
				tmp = Tempfile.new "foo"

				# Read file
				confFile = File.read(file)
				confFile.gsub!(regex, '').chomp!

				tmp.write confFile
				tmp.close

				FileUtils.mv(tmp.path, file)
				true
			rescue Exception => e
				puts e.message
				false
			end

			# returns a hash with the ruby and gemset information
			# @return [Hash]
			def rvmInfo
				rvm = {}
				rvmArray = `rvm-prompt`.chomp.split('@')
				rvm[:ruby] = rvmArray[0].split('-')[1]
				rvm[:gemset] = rvmArray[1]
				rvm
			end

			def createTmpDirIfNeeded
				FileUtils.mkdir('tmp') if !File.exist?('tmp')
			end
	end

end