#!/bin/bash

set -e

echo set configuration...

SOURCE_DIR="/var/www"
BACKUP_DIR="/opt/backups"
BACKUP_FILE="$BACKUP_DIR/$(date +%F)-backup.tar.gz"
LOG_DIR="/var/log/"
LOGS_FILE="$LOG_DIR/$(date +%F)-daily-backup-logs.log"
BACKUP_RETENTION_DAYS=7
LOGS_RETENTION_DAYS=5

EMAIL_SUB="Backup Alert"
EMAIL_DIST="shehabghazy17@gmail.com"
SUCCESS_MSG="Daily backup process completed successfully"
FAILURE_MSG="There is an issue during daily backup  process"
send_failure_email() {
  echo $FAILURE_MSG | mail -s "$EMAIL_SUB" "$EMAIL_DIST"
  echo $FAILURE_MSG
}


DATE=$(date +'%Y-%m-%d')

trap 'send_failure_email; exit 1' ERR


{
  echo  start daily backup script...
  echo backup file: $BACKUP_FILE

  sudo mkdir -p $BACKUP_DIR
  sudo tar -czf $BACKUP_FILE -C / $SOURCE_DIR

  find "$BACKUP_DIR" -name "*-backup.tar.gz" -mtime +$BACKUP_RETENTION_DAYS -exec rm -f {} \;
  echo "[$(date)] Old backups cleaned."

  find "$LOG_DIR" -name "*-daily-backup-logs.log" -mtime +$LOGS_RETENTION_DAYS -exec rm -f {} \;
  echo "[$(date)] Old logs cleaned."

} >> "$LOGS_FILE" 2>&1




echo $SUCCESS_MSG

