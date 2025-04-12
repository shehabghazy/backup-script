# Daily Backup Script

## Description
Automates system backups daily with log rotation and email alerting on failures.

## Configuration
Edit the following variables in `daily_backup.sh`:
- `SOURCE_DIR`: Directory to back up.
- `BACKUP_DIR`: Directory to store backups.
- `BACKUP_RETENTION_DAYS`: Number of days to keep old backups.
- `LOGS_RETENTION_DAYS`: Number of days to keep old logs.
- `EMAIL_DIST`: Email to notify on errors.

## Usage
Make the script executable:
```bash
chmod +x backup-script.sh


To  test it manually:
./backup-script.sh
