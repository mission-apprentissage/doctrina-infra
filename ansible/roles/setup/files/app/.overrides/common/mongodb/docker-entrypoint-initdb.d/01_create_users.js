/* eslint-disable */

db.getSiblingDB("admin").createUser({
  user: "doctrina",
  pwd: "{{ vault.LBA_MONGODB_USER_PASSWORD }}",
  roles: [{ role: "readWrite", db: "cerfa" }],
});

db.getSiblingDB("admin").createUser({
  user: "admin",
  pwd: "{{ vault.LBA_MONGODB_ADMIN_PASSWORD }}",
  roles: [
    { role: "userAdminAnyDatabase", db: "admin" },
    { role: "readWriteAnyDatabase", db: "admin" },
    { role: "dbAdminAnyDatabase", db: "admin" },
    { role: "clusterAdmin", db: "admin" },
  ],
});

db.getSiblingDB("admin").createUser({
  user: "backup",
  pwd: "{{ vault.LBA_MONGODB_BACKUP_PASSWORD }}",
  roles: [
    { role: "backup", db: "admin" },
    { role: "restore", db: "admin" },
  ],
});
