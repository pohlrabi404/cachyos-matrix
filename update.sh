#!/usr/bin/env bash
tail -n +2 cmd.sh >> install.sh
echo "#!/usr/bin/env bash" > cmd.sh
