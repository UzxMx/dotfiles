usage_bootRun() {
  cat <<-EOF
Usage: gradle bootRun

Run spring-boot based project. To run this command successfully, you must
specify 'org.springframework.boot' plugin in your build.gradle.

* Active profile

It will also ask you to specify an active spring profile. This relies on gradle
4.9+ which enables you to pass arguments to a JavaExec task (see
https://docs.gradle.org/current/javadoc/org/gradle/api/tasks/JavaExec.html#setArgsString-java.lang.String-).

* Auto-restart

When in tmux environment, this command also forks a process to build
continuously, which is required when spring-boot-devtools is used to
auto-restart the server. To use spring-boot-devtools, specify it in
build.gradle the below way:

dependencies {
  runtime 'org.springframework.boot:spring-boot-devtools'
}

Options:
  -p active profile to use, default is dev
EOF
  exit 1
}

cmd_bootRun() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -p)
        shift
        profile="$1"
        ;;
      *)
        usage_bootRun
        ;;
    esac
    shift
  done

  if [ -n "$TMUX" ]; then
    tmux split-window -h "$gradle_bin" build --continuous
  fi

  "$gradle_bin" bootRun --args="--spring.profiles.active=${profile:-dev}"
}
