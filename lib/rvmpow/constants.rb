module RvmPow
	POW_PATH = File.expand_path("~/.pow")
  RAKE_APP_DIRECTORY = File.expand_path('.')
  POW_ENV_FILE = "#{RAKE_APP_DIRECTORY}/.powenv"
  RESTART_FILE = "#{RAKE_APP_DIRECTORY}/tmp/restart.txt"
  APP_NAME = RAKE_APP_DIRECTORY.split('/').last
  POW_LINK = "#{POW_PATH}/#{APP_NAME}"
  GITIGNORE_FILE = "#{RAKE_APP_DIRECTORY}/.gitignore"
  GITIGNORE_ENTRY = "# rvmpow\n.powenv"
  GEMFILE = "#{RAKE_APP_DIRECTORY}/Gemfile"
  RVM_BINARY = "#{File.expand_path('~/')}/.rvm/bin/rvm"
  CONFIG_RU = "#{RvmPow::RAKE_APP_DIRECTORY}/config.ru"

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