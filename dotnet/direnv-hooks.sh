# dotnet direnv hooks
if [[ ":$PATH" != *":$HOME/.dotnet/tools:"* ]]; then
  export PATH="$PATH:$HOME/.dotnet/tools"
fi

if ! command -v dev-certs &>/dev/null; then
  dotnet tool update -g linux-dev-certs
  dotnet linux-dev-certs install
fi
