module RvmPow
	POW_PATH = File.expand_path("~/.pow")
  RAKE_APP_DIRECTORY = File.expand_path('.')
  POW_ENV_FILE = "#{RAKE_APP_DIRECTORY}/.powenv"
  RESTART_FILE = "#{RAKE_APP_DIRECTORY}/tmp/restart.txt"
  APP_NAME = RAKE_APP_DIRECTORY.split('/').last
  POW_LINK = "#{POW_PATH}/#{APP_NAME}"
  GITIGNORE_FILE = "#{RAKE_APP_DIRECTORY}/.gitignore"
  GITIGNORE_ENTRY = "\n# rvmpow\n.powenv"
  GEMFILE = "#{RAKE_APP_DIRECTORY}/Gemfile"
  RVM_BINARY = "#{File.expand_path('~/')}/.rvm/bin/rvm"
  CONFIG_RU = "#{RvmPow::RAKE_APP_DIRECTORY}/config.ru"
  GEMFILE_MATCHER = /.#\srvmpow.ruby\s'\d(\.\d)+'.#ruby-gemset=\S+/m
  GITIGNORE_MATCHER = /.#\srvmpow.\.powenv/m
  ADD_POWENV = "Add .powenv file"
  REMOVE_POWENV = "Remove .powenv file"
  ADD_LINK = "Add app link in ~/.pow"
  REMOVE_LINK = "Remove app link from ~/.pow"
  TOUCH_RESTART = "Touch restart.txt file in ./tmp/"
  REMOVE_RESTART = "Remove restart.txt file from ./tmp/"
  ADD_GITIGNORE = "Add '.powenv' to ./.gitignore"
  REMOVE_GITIGNORE = "Remove .powenv from ./.gitignore"
  ADD_GEMFILE = "Add rvm ruby and gemset information to ./Gemfile"
  REMOVE_GEMFILE = "Remove rvm and gemset information from ./Gemfile"

	POWENV = <<-EOF
# detect `$rvm_path`
if [ -z "${rvm_path:-}" ] && [ -x "${HOME:-}/.rvm/bin/rvm" ]
then rvm_path="${HOME:-}/.rvm"
fi
if [ -z "${rvm_path:-}" ] && [ -x "/usr/local/rvm/bin/rvm" ]
then rvm_path="/usr/local/rvm"
fi

# load environment of current project ruby
if
  [ -n "${rvm_path:-}" ] &&
  [ -x "${rvm_path:-}/bin/rvm" ] &&
  rvm_project_environment=`"${rvm_path:-}/bin/rvm" . do rvm env --path 2>/dev/null` &&
  [ -n "${rvm_project_environment:-}" ] &&
  [ -s "${rvm_project_environment:-}" ]
then
  echo "RVM loading: ${rvm_project_environment:-}"
  \. "${rvm_project_environment:-}"
else
  echo "RVM project not found at: $PWD"
fi
	EOF
end