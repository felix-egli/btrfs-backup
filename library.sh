
function title()
{
  echo "---------------------------------------------------"
  echo "$1"
  echo "---------------------------------------------------"
}

function start()
{
  local epilogue=${2:-true}

  trap '
    rc=$?
    echo "---------------------------------------------------"
    if [ $rc -eq 0 ]; then
      echo "$(date) - ok ($SECONDS)"
    else
      echo "$(date) - failed with rc=$rc ($SECONDS)"
    fi
    echo "---------------------------------------------------"
    '${epilogue}'
  ' EXIT
  title "$1"
  echo "$(date) - start"
  SECONDS=0
}

function mail()
{
  /usr/sbin/sendmail -f $MAIL_FROM $MAIL_TO <<EOF
From: $MAIL_FROM
To: $MAIL_TO
Subject: $1

$(cat -)
EOF
}
