require("dotenv").config();
const { program: cli } = require("commander");
const { getClient } = require("./api");
const { configureFirewall, activateMitigation } = require("./firewall");
const { createBackupPartition } = require("./nas");

function handleError(e) {
  console.error(e.constructor.name === "EnvVarError" ? e.message : e);
  process.exit(1); // eslint-disable-line no-process-exit
}
process.on("unhandledRejection", handleError);
process.on("uncaughtException", handleError);

cli
  .command("ping")
  .description("Permet de verifier que la clé est valide")
  .option("--key <key>", "La consumer key")
  .action(async ({ key }) => {
    let client = await getClient(key);

    await client.request("GET", `/auth/time`);
  });

cli
  .command("createFirewall <ip>")
  .description("Permet de créer/configurer le firewall et d'activer la mitigation")
  .option("--key <key>", "La consumer key")
  .action(async (ip, { key }) => {
    let client = await getClient(key);

    await configureFirewall(client, ip);
    await activateMitigation(client, ip);

    console.log(`Firewall and mitigation activated for VPS ${ip}`);
  });

cli
  .command("createBackupPartition <ip> <partitionName>")
  .description("Permet de créer une partition de backup sur le NAS")
  .option("--key <key>", "La consumer key")
  .action(async (ip, partitionName, { key }) => {
    let client = await getClient(key);

    await createBackupPartition(client, ip, partitionName);

    console.log(`NAS partition '${partitionName}' created`);
  });

cli.parse(process.argv);
