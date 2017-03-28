#!/bin/bash

if [ "${PWD##*/}" != "scripts" ] ; then
    echo "Error, this script must run from the scripts folder."
    exit 1
fi

echo -e "#!/bin/bash\n./scripts/handle_tags.sh" > "../.git/hooks/post-commit"
chmod +x ../.git/hooks/post-commit

echo -e "#!/bin/bash\n./scripts/setup_readme_version.sh" > "../.git/hooks/pre-commit"
chmod +x ../.git/hooks/pre-commit

exit 0
